output "data" {
  description = "The key vault data."
  value       = azurerm_key_vault.this
  sensitive   = false
}
