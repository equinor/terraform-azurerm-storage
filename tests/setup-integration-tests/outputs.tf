output "account_name" {
  value = "st${local.name_suffix}"
}

output "log_analytics_workspace_id" {
  value = module.log_analytics.workspace_id
}
