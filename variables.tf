variable "role_list" {
  description = "List of object ID's"
  type        = list(string)
  default     = []
}

variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resources exist."
  type        = string
}

variable "storage_account_name" {
  description = "Specifies the name of the storage account."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account."
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "Defines the access tier for the storage account."
  type        = string
  default     = "Hot"
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = true
}

variable "blob_versioning_enabled" {
  description = "Is versioning enabled for the storage account blob service?"
  type        = bool
  default     = false
}

variable "blob_change_feed_enabled" {
  description = "Is change feed enabled for the storage account blob service?"
  type        = bool
  default     = false
}

variable "blob_delete_retention_policy" {
  description = "Specifies the number of days that the blobs and containers should be retained."
  type        = number
  default     = 30
}

variable "network_ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "account_contributors" {
  description = "A list of IDs of the Azure AD objects that should be able to manage this Storage Account."
  type        = list(string)
  default     = []
}

variable "blob_contributors" {
  description = "A list of IDs of the Azure AD objects that should be able to read and write Blobs."
  type        = list(string)
  default     = []
}

variable "blob_readers" {
  description = "A list of IDs of the Azure AD objects that should be able to read Blobs."
  type        = list(string)
  default     = []
}

variable "queue_contributors" {
  description = "A list of IDs of the Azure AD objects that should be able to read and write Queues."
  type        = list(string)
  default     = []
}

variable "queue_readers" {
  description = "A list of IDs of the Azure AD objects that should be able to read Queues."
  type        = list(string)
  default     = []
}

variable "table_contributors" {
  description = "A list of IDs of the Azure AD objects that should be able to read and write Tables."
  type        = list(string)
  default     = []
}

variable "table_readers" {
  description = "A list of IDs of the Azure AD objects that should be able to read Tables."
  type        = list(string)
  default     = []
}

variable "file_contributors" {
  description = "A list of IDs of the Azure AD objects that should be able to read and write Files."
  type        = list(string)
  default     = []
}

variable "file_readers" {
  description = "A list of IDs of the Azure AD objects that should be able to read Files."
  type        = list(string)
  default     = []
}
