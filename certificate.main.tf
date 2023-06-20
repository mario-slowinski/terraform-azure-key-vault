resource "azurerm_key_vault_certificate" "imported" {
  for_each = {
    for certificate in var.certificates :
    certificate.name => certificate
    if certificate.name != null && certificate.key_vault_id != null
  }

  name         = each.key
  key_vault_id = each.value.key_vault_id

  certificate {
    contents = each.value.content_type == "application/x-pem-file" ? (
      each.value.contents
      ) : (
      filebase64(each.value.contents)
    )
    password = random_password.pfx.result
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
    lifetime_action {
      action {
        action_type = var.lifetime_action.action_type
      }
      trigger {
        days_before_expiry = var.lifetime_action.days_before_expiry
      }
    }
    secret_properties {
      content_type = each.value.content_type
    }
  }

  tags = merge(local.tags, var.tags, each.value.tags)
}
