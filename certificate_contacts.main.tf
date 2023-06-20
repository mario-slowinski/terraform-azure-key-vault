resource "azurerm_key_vault_certificate_contacts" "many" {
  key_vault_id = one(azurerm_key_vault.this[*].id)

  dynamic "contact" {
    for_each = var.certificate_contacts
    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }

  depends_on = [
    azurerm_key_vault_access_policy.many,
  ]
}
