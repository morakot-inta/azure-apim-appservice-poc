variable "create_resource_group" {
  description = "Flag to create a resource group for APIM"
  type        = bool
  default     = true
}

variable "company" {
  description = "Company name"
  type        = string
}

variable "name" {
  description = "Name of the APIM instance"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region for the APIM instance"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}