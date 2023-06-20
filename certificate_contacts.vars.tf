variable "certificate_contacts" {
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  description = "One or more contact blocks."
  default = [
    {
      email = null
    }
  ]
}
