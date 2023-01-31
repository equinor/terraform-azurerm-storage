output "storage_account_tier" {
  description = "The Tier of this Storage Account."
  value       = module.storage.account_tier
}

output "storage_account_kind" {
  description = "The Kind of this Storage Account."
  value       = module.storage.account_kind
}

output "storage_account_replication_type" {
  description = "The type of replication to use for this Storage Account."
  value       = module.storage.account_replication_type
}

