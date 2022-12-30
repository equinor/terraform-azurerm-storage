variable "account_name" {
  description = "The name of this Storage account."
  type        = string
}

variable "account_kind" {
  description = "The Kind of this Storage account."
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "The Tier of this Storage account."
  type        = string
  default     = "Standard"
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for this Storage account."
  type        = string
  default     = "RAGRS"
}

variable "access_tier" {
  description = "The access tier to use for this Storage account."
  type        = string
  default     = "Hot"
}

variable "shared_access_key_enabled" {
  description = "Is authorization with access key enabled for this Storage account?"
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled. This can be used with Azure Data Lake Storage Gen 2"
  type        = bool
  default     = false
}

variable "queue_encryption_key_type" {
  description = "The encryption type of the queue service. Possible values are Service and Account"
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "The encryption type of the table service. Possible values are Service and Account"
  type        = string
  default     = "Service"
}

variable "allow_blob_public_access" {
  description = "Allow public access to this Blob Storage?"
  type        = bool
  default     = false
}

variable "blob_properties" {
  description = "The properties of this Blob Storage."
  type = object({
    versioning_enabled                     = optional(bool, true) # Is versioning enabled for this Blob Storage?
    change_feed_enabled                    = optional(bool, true) # Is change feed enabled for this Blob Storage?
    delete_retention_policy_days           = optional(number, 35) # The number of days that deleted blobs should be retained.
    container_delete_retention_policy_days = optional(number, 35) # The number of days that deleted blob containers should be retained.
    restore_policy_days                    = optional(number, 30) # The number of days in the past to set the maximum point-in-time restore point for containers. Set value to `0` to disable.

    cors_rules = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
  })
  default = {}
}

variable "share_properties" {
  type = object({
    retention_policy_days = optional(number, 30) # The number of days that files should be retained.
  })
  default = {}
}

variable "firewall_virtual_network_subnet_ids" {
  description = "Allowed subnet resources ids using service endpoints"
  type        = list(string)
  default     = []
}

variable "firewall_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None"
  type        = list(string)
  default     = ["AzureServices"]
}

variable "firewall_ip_rules" {
  description = "The public IPs or IP ranges in CIDR format that should be able to access this Storage account. Only IPv4 addresses are allowed."
  type        = list(string)
  default     = []
}

variable "firewall_default_action" {
  description = "Specifies the default action of allow or deny when no other rules match."
  type        = string
  default     = "Deny"
}

variable "threat_protection_enabled" {
  description = "Is threat protection (Microsoft Defender for Storage) enabled for this Storage account?"
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
