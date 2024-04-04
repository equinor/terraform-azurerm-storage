variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
  nullable    = false
}

variable "account_name" {
  description = "The name of this Storage account."
  type        = string
  nullable    = false
}

variable "account_kind" {
  description = "The kind of Storage account to create. Value must be \"StorageV2\", \"BlobStorage\", \"BlockBlobStorage\" or \"FileStorage\"."
  type        = string
  default     = "StorageV2"
  nullable    = false

  validation {
    condition     = contains(["StorageV2", "BlobStorage", "BlockBlobStorage", "FileStorage"], var.account_kind)
    error_message = "Account kind must be \"Standard\" or \"Premium\"."
  }
}

variable "account_tier" {
  description = "The performance tier of this Storage account. Value must be \"Standard\" or \"Premium\"."
  type        = string
  default     = "Standard"
  nullable    = false

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be \"Standard\" or \"Premium\"."
  }
}

variable "account_replication_type" {
  description = "The type of replication to use for this Storage account. Value must be \"LRS\", \"ZRS\", \"GRS\", \"RAGRS\", \"GZRS\" or \"RAGZRS\"."
  type        = string
  default     = "RAGRS"
  nullable    = false

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Account replication type must be \"LRS\", \"ZRS\", \"GRS\", \"RAGRS\", \"GZRS\" or \"RAGZRS\"."
  }
}

variable "access_tier" {
  description = "The access tier to use for this Storage account. Value must be \"Hot\" or \"Cool\"."
  type        = string
  default     = "Hot"
  nullable    = false

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Account replication type must be \"Hot\" or \"Cool\"."
  }
}

variable "shared_access_key_enabled" {
  description = "Is authorization with access key enabled for this Storage account?"
  type        = bool
  default     = false
  nullable    = false
}

variable "is_hns_enabled" {
  description = "Is Data Lake Storage Gen2 hierarchical namespace (HNS) enabled for this Storage account?"
  type        = bool
  default     = false
  nullable    = false
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

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Allow cross-tenant replication?"
  type        = bool
  default     = false
}

variable "blob_versioning_enabled" {
  description = "Is versioning enabled for this Blob Storage?"
  type        = bool
  default     = true
}

variable "blob_change_feed_enabled" {
  description = "Is change feed enabled for this Blob Storage?"
  type        = bool
  default     = true
}

variable "last_access_time_enabled" {
  description = "(Optional) Is the last access time based tracking enabled?"
  type        = bool
  default     = false
}

variable "blob_delete_retention_policy_days" {
  description = "The number of days that deleted blobs should be retained."
  type        = number
  default     = 7
}

variable "blob_container_delete_retention_policy_days" {
  description = "The number of days that deleted blob containers should be retained."
  type        = number
  default     = 7
}

variable "blob_restore_policy_days" {
  description = "The number of days in the past to set the maximum point-in-time restore point for containers. Set value to `0` to disable."
  type        = number
  default     = 6
}

variable "blob_cors_rules" {
  description = "A list of CORS rules to configure for this Blob storage."

  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))

  default = []
}

variable "share_retention_policy_days" {
  description = "The number of days that files should be retained."
  type        = number
  default     = 7
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Web App."
  type        = list(string)
  default     = []
}

variable "network_rules_default_action" {
  description = "The default action of the network rules for this Storage account."
  type        = string
  default     = "Deny"
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
  description = "The public IPs or IP ranges in CIDR format that should be able to access this Storage account. Only IP ranges with 0-30 number of bits as prefix are allowed."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for ip_rule in var.network_rules_ip_rules : can(cidrhost("${ip_rule}/32", 0)) || can(cidrhost(ip_rule, 0))])
    error_message = "Invalid public IPs or IP ranges. Must be in CIDR format."
  }

  validation {
    condition     = alltrue([for ip_rule in var.network_rules_ip_rules : try(split("/", ip_rule)[1], 0) < 31])
    error_message = "Invalid IP range prefix. Only 0-30 number of bits allowed."
  }
}

variable "private_link_accesses" {
  description = "A list of private link accesses to configure for this Storage account."
  type = list(object({
    endpoint_resource_id = string
    endpoint_tenant_id   = optional(string)
  }))
  default = []
}

variable "custom_domain" {
  description = "A custom (sub) domain name of the Storage Account"

  type = object({
    name          = string
    use_subdomain = optional(bool, false)
  })

  default = null
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
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

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
}

variable "advanced_threat_protection_enabled" {
  description = "Should Defender for Storage (classic) advanced threat protection be enabled for this Storage account?"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
