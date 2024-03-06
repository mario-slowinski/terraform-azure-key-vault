resource "azurerm_key_vault_certificate_contacts" "key-vault" {
  for_each = var.name != null ? toset([var.name]) : toset([])

  key_vault_id = azurerm_key_vault.name[each.value].id

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
