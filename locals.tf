data "azurerm_user_assigned_identity" "github_oidc" {
  count               = var.managed_identity_ids == "" ? 0 : 1
  name                = "github-oidc-${var.project}-${var.environment}"
  resource_group_name = "rg-${var.project}-identity"
}

locals {
  vnet_subnets        = formatlist("%s", values(var.vnet_subnet_ids))
  private_dns_zone_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.dns_zone_resource_group}/providers/Microsoft.Network/privateDnsZones/${var.private_dns_zone_name}"
}
