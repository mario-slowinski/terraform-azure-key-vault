output "data" {
  description = "The key vault data."
  value       = azurerm_key_vault.this
  sensitive   = false
}

output "certificate" {
  description = "The certificate"
  value       = one(azurerm_key_vault_certificate.this[*])
}
