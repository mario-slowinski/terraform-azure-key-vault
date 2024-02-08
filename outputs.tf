output "data" {
  description = "The key vault data."
  value       = try(azurerm_key_vault.name[var.name], null)
  sensitive   = false
}

output "secrets" {
  description = "The list of key vault secrets."
  value       = { for name, secret in azurerm_key_vault_secret.name : name => merge(secret, { value = null }) }
  sensitive   = false
}
