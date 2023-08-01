resource "azurerm_key_vault_certificate" "imported" {
  for_each = {
    for certificate in var.certificates :
    certificate.name => certificate
    if certificate.name != null && certificate.contents != null
  }

  name         = each.key
  key_vault_id = coalesce(each.value.key_vault_id, try(azurerm_key_vault.name[local.name].id, null))

  certificate {
    contents = each.value.content_type == "application/x-pem-file" ? (
      each.value.contents
      ) : (
      filebase64(each.value.contents)
    )
    password = each.value.password
  }

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }
    key_properties {
      curve      = each.value.key_properties.curve
      exportable = each.value.key_properties.exportable
      key_type   = each.value.key_properties.key_type
      key_size   = each.value.key_properties.key_size
      reuse_key  = each.value.key_properties.reuse_key
    }
    dynamic "lifetime_action" {
      for_each = toset([merge(var.certificate__lifetime_action, each.value.lifetime_action)])
      content {
        action {
          action_type = lifetime_action.value.action.action_type
        }
        trigger {
          days_before_expiry  = lifetime_action.value.trigger.days_before_expiry
          lifetime_percentage = lifetime_action.value.trigger.lifetime_percentage
        }
      }
    }
    secret_properties {
      content_type = each.value.content_type
    }
  }

  tags = merge(local.tags, var.tags, each.value.tags)
}
