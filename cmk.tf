resource "random_string" "key" {
  length  = 2
  special = false
  numeric = true
  lower   = true
}

resource "azurerm_key_vault_key" "this" {
  #checkov:skip=CKV_AZURE_112 "Ensure key vault key is backed by HSM" -- currently not required
  count        = var.managed_identity_ids == "" ? 0 : 1
  name         = "${var.storage_account_prefix}-key-${random_string.key.result}-${var.postfix}"
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]
  expiration_date = timeadd(timestamp(), format("%sh", var.cmk_lifetime_in_hours))
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  count                     = var.managed_identity_ids == "" ? 0 : 1
  storage_account_id        = azurerm_storage_account.this.id
  key_vault_id              = var.key_vault_id
  key_name                  = azurerm_key_vault_key.this[0].name
  user_assigned_identity_id = data.azurerm_user_assigned_identity.github_oidc[0].id
  depends_on                = [azurerm_key_vault_key.this]
}
