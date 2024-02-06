resource "azurerm_key_vault_secret" "name" {
  for_each = {
    for secret in var.secrets :
    secret.name => secret
    if secret.name != null
  }

  key_vault_id    = coalesce(each.value.key_vault_id, try(azurerm_key_vault.name[var.name].id, null))
  name            = each.value.name
  value           = each.value.value
  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
  tags            = each.value.tags
}
