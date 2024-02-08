variable "secrets" {
  type = list(object({
    name            = string                # Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created.
    value           = optional(string)      # Specifies the value of the Key Vault Secret or random generated. Changing this will create a new version of the Key Vault Secret.
    key_vault_id    = optional(string)      # The ID of the Key Vault where the Secret should be created.
    content_type    = optional(string)      # Specifies the content type for the Key Vault Secret.
    tags            = optional(map(string)) # A mapping of tags to assign to the resource.
    not_before_date = optional(string)      # Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    expiration_date = optional(string)      # Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
  }))
  description = "List of Key Vault Secrets."
  default     = [{ name = null, value = null }]
}
