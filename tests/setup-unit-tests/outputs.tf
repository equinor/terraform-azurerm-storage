output "account_name" {
  value = "st${local.name_suffix}"
}

output "resource_group_name" {
  value = "rg-${local.name_suffix}"
}

output "location" {
  value = "northeurope"
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/log-${local.name_suffix}"
}
