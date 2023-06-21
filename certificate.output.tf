output "certificate-id" {
  description = "The Key Vault Certificate ID."
  value = {
    for certificate in azurerm_key_vault_certificate.imported :
    certificate.name => certificate.id
  }
}

output "certificate-secret_id" {
  description = "The ID of the associated Key Vault Secret."
  value = {
    for certificate in azurerm_key_vault_certificate.imported :
    certificate.name => certificate.secret_id
  }
}
