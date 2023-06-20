variable "certificates" {
  type = list(object({
    content_type = string           # Certificate type
    contents     = string           # Certificate contents (key in pkcs8 and crt in PEM) or path to PFX file
    key_properties = object({       # Map of key arguments.
      curve      = optional(string) # Specifies the curve to use when creating an EC key.
      exportable = bool             # Is this certificate exportable?
      key_size   = optional(number) # The size of the key used in the certificate.
      key_type   = string           # Specifies the type of key.
      reuse_key  = bool             # Is the key reusable?
    })
    key_vault_id = string               # The ID of the Key Vault where the Certificate should be created.
    lifetime_action = optional(object({ # Map of lifetime_action arguments.
      action = object({                 # A action block
        action_type = string            #  The Type of action to be performed when the lifetime trigger is triggered.
      })
      trigger = object({                       # A trigger block.
        days_before_expiry  = optional(number) #  The number of days before the Certificate expires that the action associated with this Trigger should run.
        lifetime_percentage = optional(number) # The percentage at which during the Certificates Lifetime the action associated with this Trigger should run.
      })
    }))
    name = string # Specifies the name of the Key Vault Certificate.
    tags = optional(map(string))
  }))
  default = [
    {
      name         = null
      content_type = null
      contents     = null
      key_properties = {
        exportable = null
        key_type   = null
        reuse_key  = null
      }
      key_vault_id = null
    },
  ]
  validation {
    condition     = length(setintersection(["application/x-pem-file", "application/x-pkcs12"], var.certificates[*].content_type)) > 0
    error_message = "Possible values: application/x-pem-file, application/x-pkcs12"
  }
}

<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
variable "key_properties" {
  type = object({
    curve      = optional(string) # Specifies the curve to use when creating an EC key.
    exportable = bool             # Is this certificate exportable?
    key_size   = optional(number) # The size of the key used in the certificate.
    key_type   = string           # Specifies the type of key.
    reuse_key  = bool             # Is the key reusable?
=======
variable "certificate__lifetime_action" {
  type = object({          # Map of lifetime_action arguments.
    action = object({      # A action block
      action_type = string #  The Type of action to be performed when the lifetime trigger is triggered.
    })
    trigger = object({                       # A trigger block.
      days_before_expiry  = optional(number) #  The number of days before the Certificate expires that the action associated with this Trigger should run.
      lifetime_percentage = optional(number) # The percentage at which during the Certificates Lifetime the action associated with this Trigger should run.
    })
>>>>>>> Stashed changes
  })
  default = {
    action = {
      action_type = "EmailContacts"
    }
    trigger = {
      days_before_expiry = 14
    }
  }
}
