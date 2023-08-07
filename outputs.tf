output "data" {
  description = "The key vault data."
  value       = try(azurerm_key_vault.name[var.name], null)
  sensitive   = false
}
