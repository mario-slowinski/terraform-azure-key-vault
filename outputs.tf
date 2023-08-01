output "data" {
  description = "The key vault data."
  value       = try(azurerm_key_vault.name[local.name], null)
  sensitive   = false
}
