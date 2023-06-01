variable "action_name" {
    type        = string
    description = "Name of the data action." 
}

variable "action_category" {
    type        = string
    description = "Category of action."
}

variable "integration_id" {
    type        = string
    description = "Genesys Cloud integration id the data action will be associated with."
}

variable "secure_data_action" {
    type        = bool
    description = "True, Secure Data Action can only be invoked from a Secure flow. False, can be called from any flow."
    default     = false
}