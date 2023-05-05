variable "access_policies" {
  type = list(object({
    tenant_id               = optional(string)
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  description = "Maximum of 1024 Access Policies per Key Vault."
  default = [
    {
      object_id = "current"
      certificate_permissions = [
        "ManageContacts",
      ]
    }
  ]
}
