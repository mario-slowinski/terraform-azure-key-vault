resource "azurerm_key_vault_certificate_contacts" "list" {
  key_vault_id = azurerm_key_vault.name[var.name].id

  dynamic "contact" {
    for_each = {
      for certificate_contact in var.certificate_contacts :
      certificate_contact.email => certificate_contact
      if certificate_contact.email != null
    }
    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }

  depends_on = [
    azurerm_key_vault.name,
  ]
}
