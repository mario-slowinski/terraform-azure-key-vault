variable "role_assignments" {
  type = list(object({
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    principal_id                           = string
    condition                              = optional(string)
    condition_version                      = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
    })
  )
  description = "Assign role to principal_id for this key vault."
  default = [
    {
      principal_id = ""
    },
  ]
}
