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
  default     = true
}

variable "allow_blob_public_access" {
  description = "Allow public access to this Blob Storage?"
  type        = bool
  default     = false
}

variable "blob_version_retention_days" {
  description = "The number of days that previous versions of blobs should be retained."
  type        = number
  default     = 7
}

variable "blob_delete_retention_days" {
  description = "The number of days that deleted blobs and containers should be retained."
  type        = number
  default     = 35
}

variable "blob_pitr_days" {
  description = "The number of days in the past to set the maximum point-in-time restore point for containers. Must be less than 'blob_delete_retention_days'."
  type        = number
  default     = 30
}

variable "file_retention_policy" {
  description = "The number of days that files should be retained."
  type        = number
  default     = 30
}

variable "firewall_ip_rules" {
  description = "The public IPs or IP ranges in CIDR format that should be able to access this Storage Account. Only IPv4 addresses are allowed."
  type        = list(string)
  default     = []
}

variable "threat_protection_enabled" {
  description = "Is threat protection (Microsoft Defender for Storage) enabled for this Storage Account?"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace to send diagnostics to."
  type        = string
}
