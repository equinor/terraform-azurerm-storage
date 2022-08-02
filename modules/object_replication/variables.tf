variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "location" {
  description = "The supported Azure location where the resources exist."
  type        = string
}

variable "account_name" {
  description = "A custom name for this Storage Account."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for this Storage Account."
  type        = string
  default     = "RAGRS"
}

variable "access_tier" {
  description = "The access tier to use for this Storage Account."
  type        = string
  default     = "Hot"
}

variable "shared_access_key_enabled" {
  description = "Is authorization with access key enabled for this Storage Account?"
  type        = bool
  default     = false
}

variable "allow_blob_public_access" {
  description = "Allow public access to this Blob Storage?"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
