variable "certificate_pem" {
  type        = string
  description = "Certificate in PEM format."
  default     = null
}

variable "private_key_pem" {
  type        = string
  description = "Private key in PEM format."
  default     = null
  sensitive   = true
}

variable "certificate_name" {
  type        = string
  description = "Specifies the name of the Key Vault Certificate."
  default     = null
}

variable "certs" {
  type        = string
  description = "Directory where save TLS keys and certificates."
  default     = "files"
}

variable "content_type" {
  type        = string
  description = "Certificate type"
  default     = "application/x-pem-file"
  validation {
    condition     = contains(["application/x-pem-file", "application/x-pkcs12"], var.content_type)
    error_message = "Possible values: application/x-pem-file, application/x-pkcs12"
  }
}

variable "key_properties" {
  type = object({
    curve      = optional(string) # Specifies the curve to use when creating an EC key.
    exportable = bool             # Is this certificate exportable?
    key_size   = optional(number) # The size of the key used in the certificate.
    key_type   = string           # Specifies the type of key.
    reuse_key  = bool             # Is the key reusable?
  })
  description = "Map of key arguments."
  default = {
    exportable = null
    key_type   = null
    reuse_key  = null
  }
}

variable "lifetime_action" {
  type        = map(string)
  description = "Map of lifetime_action arguments."
  default = {
    action_type        = "EmailContacts"
    days_before_expiry = 14
  }
}
