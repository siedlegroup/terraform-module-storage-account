output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "storage_account_uri" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}
