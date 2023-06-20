variable "name" {
  type        = string
  description = "Specifies the name of the Key Vault."
  default     = null
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
  default     = null
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault."
  default     = "standard"
  validation {
    condition     = var.sku_name == "standard" || var.sku_name == "premium"
    error_message = "Possible values are standard and premium."
  }
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  default     = null
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = true
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = true
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = null
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = null
}

variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  description = "Optional block."
  default = {
    bypass         = null
    default_action = null
  }
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault?"
  default     = null
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted."
  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "This value can be between 7 and 90 (the default) days."
  }
  default = 90
}
