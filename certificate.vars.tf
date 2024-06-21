variable "certificates" {
  type = list(object({
    name         = string           # Specifies the name of the Key Vault Certificate.
    key_vault_id = optional(string) # The ID of the Key Vault where the Certificate should be created. Use the one from this module if set to null
    certificate = optional(object({ # Required when x509_certificate_properties block is not specified.
      contents = string             # Certificate contents (key in pkcs8 and crt in PEM) or path to PFX file
      password = optional(string)   # PFX file password
    }))
    # All below belongs to certificate_policy block
    key_properties = object({
      curve      = optional(string) # Specifies the curve to use when creating an EC key.
      exportable = bool             # Is this certificate exportable?
      key_size   = optional(number) # The size of the key used in the certificate.
      key_type   = string           # Specifies the type of key.
      reuse_key  = bool             # Is the key reusable?
    })
    lifetime_action = optional(object({
      action = object({
        action_type = string # The Type of action to be performed when the lifetime trigger is triggered. Possible values include AutoRenew and EmailContacts.
      })
      trigger = object({
        days_before_expiry  = optional(number) # The number of days before the Certificate expires that the action associated with this Trigger should run.
        lifetime_percentage = optional(number) # The percentage at which during the Certificates Lifetime the action associated with this Trigger should run.
      })
    }))
    secret_properties = object({
      content_type = string # The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM.
    })
    x509_certificate_properties = optional(object({ # Required when certificate block is not specified.
      extended_key_usage = optional(list(string))   # A list of Extended/Enhanced Key Usages.
      key_usage          = list(string)             # A list of uses associated with this Key. Possible values include cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation and are case-sensitive.
      subject            = string                   # The Certificate's Subject.
      subject_alternative_names = optional(object({
        dns_names = optional(list(string)) # A list of alternative DNS names (FQDNs) identified by the Certificate.
        emails    = optional(list(string)) # A list of email addresses identified by this Certificate.
        upns      = optional(list(string)) # A list of User Principal Names identified by the Certificate.
      }))
      validity_in_months = number # The Certificates Validity Period in Months.
    }))
    tags = optional(map(string)) # A mapping of tags to assign to the resource.
  }))
  default = [
    {
      name              = null
      secret_properties = { content_type = "application/x-pkcs12" }
      key_properties = {
        exportable = null
        key_type   = null
        reuse_key  = null
      }
      key_vault_id = null
    },
  ]
  validation {
    condition     = length(setintersection(["application/x-pem-file", "application/x-pkcs12"], var.certificates[*].secret_properties.content_type)) > 0
    error_message = "Possible values: application/x-pem-file, application/x-pkcs12"
  }
}

variable "certificate__lifetime_action" {
  type = object({          # Map of lifetime_action arguments.
    action = object({      # A action block
      action_type = string #  The Type of action to be performed when the lifetime trigger is triggered.
    })
    trigger = object({                       # A trigger block.
      days_before_expiry  = optional(number) #  The number of days before the Certificate expires that the action associated with this Trigger should run.
      lifetime_percentage = optional(number) # The percentage at which during the Certificates Lifetime the action associated with this Trigger should run.
    })
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
