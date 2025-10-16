variable "name_prefix" {
    type = string
    description = "A prefix to put at the front of the roles and policies."
}

variable "additional_permissions" {
    type = string
    description = "Any additional permissions that the executor will need."
    default = ""
}
