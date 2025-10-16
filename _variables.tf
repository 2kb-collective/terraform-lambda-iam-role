variable "name_prefix" {
    type = string
    description = "A prefix to put at the front of the roles and policies."
}

variable "inline_policy_json" {
    type = string
    description = "Any additional permissions that the executor will need."
    default = null
}

variable "create_inline_policy" {
  type    = bool
  default = false
}