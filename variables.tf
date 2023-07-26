variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

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
  description = "Is Data Lake Storage Gen2 hierarchical namespace enabled for this Storage account?"
  type        = bool
  default     = false
}

variable "queue_encryption_key_type" {
  description = "The type of encryption to use for this Queue Storage."
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "The type of encryption to use for this Table Storage."
  type        = string
  default     = "Service"
}

variable "allow_blob_public_access" {
  description = "Allow public access to this Blob Storage?"
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Allow cross-tenant replication?"
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

variable "queue_properties" {
  description = "The properties of this Queue Storage."

  type = object({
    logging_delete                       = optional(bool, true)
    logging_read                         = optional(bool, true)
    logging_write                        = optional(bool, true)
    logging_version                      = optional(string, "1.0")
    logging_retention_policy_days        = optional(number, 10)
    hour_metrics_enabled                 = optional(bool, true)
    hour_metrics_include_apis            = optional(bool, true)
    hour_metrics_version                 = optional(string, "1.0")
    hour_metrics_retention_policy_days   = optional(number, 10)
    minute_metrics_enabled               = optional(bool, true)
    minute_metrics_include_apis          = optional(bool, true)
    minute_metrics_version               = optional(string, "1.0")
    minute_metrics_retention_policy_days = optional(number, 10)
  })

  default = {}
}

variable "identity" {
  description = "The identity to configure for this Storage account."

  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
  })

  default = null
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "Allowed subnet resources ids using service endpoints"
  type        = list(string)
  default     = []
}

variable "network_rules_bypass_azure_services" {
  description = "Should Azure services be allowed to bypass the network rules for this Storage account?"
  type        = bool
  default     = true
}

variable "network_rules_ip_rules" {
  description = "The public IPs or IP ranges in CIDR format that should be able to access this Storage account. Only IPv4 addresses are allowed."
  type        = list(string)
  default     = []
}

variable "custom_domain" {
  description = "A custom (sub) domain name of the Storage Account"

  type = object({
    name          = string
    use_subdomain = optional(bool, false)
  })

  default = null
}

variable "advanced_threat_protection_enabled" {
  description = "Is advanced threat protection (Microsoft Defender for Storage) enabled for this Storage account?"
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)

  default = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
