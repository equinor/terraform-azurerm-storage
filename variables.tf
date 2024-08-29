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
  description = "The type of encryption to use for this Queue Storage. Value must be \"Service\" or \"Account\"."
  type        = string
  default     = "Service"
  nullable    = false

  validation {
    condition     = contains(["Service", "Account"], var.queue_encryption_key_type)
    error_message = "Queue encryption key type must be \"Service\" or \"Account\"."
  }
}

variable "table_encryption_key_type" {
  description = "The type of encryption to use for this Table Storage. Value must be \"Service\" or \"Account\"."
  type        = string
  default     = "Service"
  nullable    = false

  validation {
    condition     = contains(["Service", "Account"], var.table_encryption_key_type)
    error_message = "Table encryption key type must be \"Service\" or \"Account\"."
  }
}

variable "allow_blob_public_access" {
  description = "Allow public access to this Blob Storage?"
  type        = bool
  default     = false
  nullable    = false
}

variable "default_to_oauth_authentication" {
  description = "Default to Entra ID authorization in the Azure Portal when accessing this Storage account?"
  type        = bool
  default     = true
  nullable    = false
}

variable "cross_tenant_replication_enabled" {
  description = "Allow cross-tenant replication for this Storage account?"
  type        = bool
  default     = false
  nullable    = false
}

variable "blob_versioning_enabled" {
  description = "Is versioning enabled for this Blob Storage?"
  type        = bool
  default     = true
  nullable    = false
}

variable "blob_change_feed_enabled" {
  description = "Is change feed enabled for this Blob Storage?"
  type        = bool
  default     = true
  nullable    = false
}

variable "last_access_time_enabled" {
  description = "Is last access time tracking enabled for this Blob Storage?"
  type        = bool
  default     = false
  nullable    = false
}

variable "blob_delete_retention_policy_days" {
  description = "The number of days that deleted blobs should be retained. Value must be between 1 and 365."
  type        = number
  default     = 7
  nullable    = false

  validation {
    condition     = var.blob_delete_retention_policy_days >= 1 && var.blob_delete_retention_policy_days <= 365
    error_message = "Blob delete retention policy days must be between 1 and 365."
  }
}

variable "blob_container_delete_retention_policy_days" {
  description = "The number of days that deleted blob containers should be retained. Value must be between 1 and 365."
  type        = number
  default     = 7
  nullable    = false

  validation {
    condition     = var.blob_container_delete_retention_policy_days >= 1 && var.blob_container_delete_retention_policy_days <= 365
    error_message = "Blob container delete retention policy days must be between 1 and 365."
  }
}

variable "blob_restore_policy_days" {
  description = "The number of days in the past to set the maximum point-in-time restore point for containers. Value must be between 0 and 364, and less than the blob delete retention policy."
  type        = number
  default     = 6
  nullable    = false

  validation {
    condition     = var.blob_restore_policy_days >= 0 && var.blob_restore_policy_days <= 364
    error_message = "Blob restore policy days must be between 0 and 365."
  }
}

variable "blob_cors_rules" {
  description = "A list of CORS rules to configure for this Blob Storage."

  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))

  default  = []
  nullable = false
}

variable "share_retention_policy_days" {
  description = "The number of days that files should be retained. Value must be between 1 and 365."
  type        = number
  default     = 7
  nullable    = false

  validation {
    condition     = var.share_retention_policy_days >= 1 && var.share_retention_policy_days <= 365
    error_message = "Share retention policy days must be between 1 and 365."
  }
}

variable "share_cors_rules" {
  description = "A list of CORS rules to configure for this File Storage."

  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))

  default  = []
  nullable = false
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = false
  nullable    = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Web App."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "network_rules_default_action" {
  description = "The default action of the network rules for this Storage account. Value must be \"Allow\" or \"Deny\"."
  type        = string
  default     = "Deny"
  nullable    = false

  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "Network rules default action must be \"Allow\" or \"Deny\"."
  }
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "A list of virtual subnet IDs that should be able to bypass the network rules for this Storage account."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "network_rules_bypass_azure_services" {
  description = "Should Azure services be allowed to bypass the network rules for this Storage account?"
  type        = bool
  default     = true
  nullable    = false
}

variable "network_rules_ip_rules" {
  description = "A list of public IPs or IP ranges that should be able to bypass the network rules for this Storage account. Values must be in CIDR format, and only IP ranges with 0-30 number of bits as prefix are allowed."
  type        = list(string)
  default     = []
  nullable    = false

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

  default  = []
  nullable = false
}

variable "custom_domain" {
  description = "A custom domain (or subdomain) name for this Storage account."

  type = object({
    name          = string
    use_subdomain = optional(bool, false)
  })

  default  = null
  nullable = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
  nullable    = false
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
  nullable    = false
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["StorageRead", "StorageWrite", "StorageDelete"]
  nullable    = false
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "action_group_id" {
  description = "The ID of the action group to send alerts to."
  type        = string
  nullable    = false
}

variable "advanced_threat_protection_enabled" {
  description = "Should Defender for Storage (classic) advanced threat protection be enabled for this Storage account?"
  type        = bool
  default     = true
  nullable    = false
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
  nullable    = false
}
