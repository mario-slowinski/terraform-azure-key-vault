  count = var.key_vault_id != null ? 1 : 0
resource "azurerm_key_vault_certificate" "imported" {

  name         = var.certificate_name
  key_vault_id = var.key_vault_id

  certificate {
    contents = var.content_type == "application/x-pem-file" ? (
      join("", [
        var.private_key_pem,
        var.certificate_pem,
        ]
      )
      ) : (
      filebase64("${path.root}/${var.certs}/${var.certificate_name}.pfx")
    )
    password = random_password.pfx.result
  }

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }
    key_properties {
      curve      = var.key_properties.curve
      exportable = var.key_properties.exportable
      key_type   = var.key_properties.key_type
      key_size   = var.key_properties.key_size
      reuse_key  = var.key_properties.reuse_key
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
      content_type = var.content_type
    }
  }

  tags = merge(local.tags, var.tags)
}
