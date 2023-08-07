resource "azurerm_key_vault_certificate_contacts" "email" {
  for_each = {
    for certificate_contact in var.certificate_contacts :
    certificate_contact.email => certificate_contact
    if certificate_contact.email != null
  }

  contact {
    email = each.key
    name  = each.value.name
    phone = each.value.phone
  }
  key_vault_id = azurerm_key_vault.name[var.name].id

  depends_on = [
    azurerm_key_vault.name,
    azurerm_key_vault_access_policy.object_id,
  ]
}
