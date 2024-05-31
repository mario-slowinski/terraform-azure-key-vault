output "id" {
  description = "The key vault id."
  value       = try(azurerm_key_vault.name[var.name].id, null)
  sensitive   = false
}

output "data" {
  description = "The key vault data."
  value       = try(azurerm_key_vault.name[var.name], null)
  sensitive   = false
}

output "certificate_ids" {
  description = "Key Vault Certificates IDs."
  value       = { for name, certificate in azurerm_key_vault_certificate.imported : name => certificate.resource_manager_versionless_id }
  sensitive   = false
}

output "secrets" {
  description = "The list of key vault secrets."
  value       = { for name, secret in azurerm_key_vault_secret.name : name => merge(secret, { value = null }) }
  sensitive   = false
}
