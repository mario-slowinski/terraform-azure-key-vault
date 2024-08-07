resource "azurerm_key_vault_certificate" "imported" {
  for_each = {
    for certificate in var.certificates :
    certificate.name => certificate
    if certificate.name != null
  }

  name         = each.key
  key_vault_id = coalesce(each.value.key_vault_id, try(azurerm_key_vault.name[var.name].id, null))

  dynamic "certificate" {
    for_each = each.value.certificate.contents != null ? toset([0]) : toset([])
    content {
      contents = each.value.secret_properties.content_type == "application/x-pem-file" ? (
        each.value.certificate.contents
        ) : (
        filebase64(each.value.certificate.contents)
      )
      password = each.value.certificate.password
    }
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
      content_type = each.value.secret_properties.content_type
    }

    dynamic "x509_certificate_properties" {
      for_each = each.value.x509_certificate_properties != null ? toset([each.value.x509_certificate_properties]) : toset([])
      content {
        extended_key_usage = x509_certificate_properties.value.extended_key_usage
        key_usage          = x509_certificate_properties.value.key_usage
        subject            = x509_certificate_properties.value.subject
        validity_in_months = x509_certificate_properties.value.validity_in_months
      }
    }
  }

  tags = merge(var.tags, each.value.tags)
}
