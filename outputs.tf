output "data" {
  description = "The key vault data."
  value       = azurerm_key_vault.name[local.name]
  sensitive   = false
}
