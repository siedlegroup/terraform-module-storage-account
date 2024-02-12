# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#argument-reference

data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "this" {
  #checkov:skip=CKV_AZURE_206: "Ensure that Storage Accounts use replication" - not desired
  #checkov:skip=CKV_AZURE_33: "Ensure Storage logging is enabled for Queue service for read, write and delete requests" - not desired
  #checkov:skip=CKV_AZURE_43: "Ensure Storage Accounts adhere to the naming rules" - false positive
  #checkov:skip=CKV2_AZURE_38: "Ensure soft-delete is enabled on Azure storage account" - false positive
  #checkov:skip=CKV_AZURE_44: "Ensure that minimum TLS version is set to TLS1_2" - false positive
  #checkov:skip=CKV2_AZURE_1: "Ensure Storage Account is encrypted with CMK" - CMK exists in separate resource
  #checkov:skip=CKV2_AZURE_40: "Ensure storage account is not configure with Shared Key authorization" - false positive

  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.storage_account_tier
  account_replication_type          = var.account_replication_type
  public_network_access_enabled     = var.public_network_access_enabled
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  min_tls_version                   = var.min_tls_version
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  enable_https_traffic_only         = true

  identity {
    type         = var.managed_identity_ids == "" ? "SystemAssigned" : "SystemAssigned, UserAssigned"
    identity_ids = var.managed_identity_ids == "" ? [] : [data.azurerm_user_assigned_identity.github_oidc[0].id]
  }
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = concat(local.vnet_subnets, var.shared_subnet_ids)
  }


  sas_policy {
    expiration_action = "Log"
    expiration_period = "01.00:00:00"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}

resource "azurerm_private_endpoint" "this" {
  count                         = var.private_link_endpoint_enabled ? 1 : 0
  name                          = "${var.storage_account_prefix}-${var.postfix}-private-endpoint"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.vnet_subnet_ids["subnet2-${var.postfix}"]
  custom_network_interface_name = "${var.storage_account_prefix}-${var.postfix}-private-endpoint-nic"
  private_service_connection {
    name                           = azurerm_storage_account.this.name
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "${var.storage_account_prefix}-${var.project}"
    private_dns_zone_ids = [local.private_dns_zone_id]
  }
}
