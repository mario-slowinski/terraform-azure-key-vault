resource "azurerm_key_vault_access_policy" "many" {
  for_each = {
    for access_policy in var.access_policies :
    access_policy.object_id => access_policy
    if access_policy.object_id != ""
  }

  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = azurerm_key_vault.this.tenant_id
  object_id               = each.key
  application_id          = each.value.application_id
  certificate_permissions = each.value.certificate_permissions
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  storage_permissions     = each.value.storage_permissions

  depends_on = [
    azurerm_key_vault.this,
  ]
}
