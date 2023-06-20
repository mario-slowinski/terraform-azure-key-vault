resource "azurerm_role_assignment" "many" {
  for_each = {
    for role_assignment in var.role_assignments :
    role_assignment.principal_id => role_assignment
    if role_assignment.principal_id != ""
  }

  scope                                  = one(azurerm_key_vault.this[*].id)
  role_definition_id                     = each.value.role_definition_id
  role_definition_name                   = each.value.role_definition_name
  principal_id                           = each.key
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check

  depends_on = [
    azurerm_key_vault.this,
  ]
}
