mock_provider "azurerm" {
  # Override values that are not known until after the plan is applied.
  override_during = plan

  override_resource {
    target = azurerm_storage_account.this
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resources/providers/Microsoft.Storage/storageAccounts/example-storage"
    }
  }

  override_resource {
    target = azurerm_monitor_diagnostic_setting.this
    values = {
      log_analytics_destination_type = null
    }
  }
}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "monitoring_defaults" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = alltrue([for value in azurerm_monitor_diagnostic_setting.this : value.name == "audit-logs"])
    error_message = "Diagnostic setting name should be \"audit-logs\" by default"
  }

  assert {
    condition     = alltrue([for key, value in azurerm_monitor_diagnostic_setting.this : value.target_resource_id == "${azurerm_storage_account.this.id}/${key}Services/default"])
    error_message = "Diagnostic setting should be linked to the Storage account resource"
  }

  assert {
    condition     = alltrue([for value in azurerm_monitor_diagnostic_setting.this : value.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id])
    error_message = "Diagnostic setting should be linked to the setup test Log Analytics workspace"
  }

  assert {
    condition     = alltrue([for value in azurerm_monitor_diagnostic_setting.this : value.log_analytics_destination_type == null])
    error_message = "Diagnostic setting should not have a Log Analytics destination type configured for Storage account"
  }

  assert {
    condition     = alltrue([for value in azurerm_monitor_diagnostic_setting.this : length(value.enabled_log) == 3]) && alltrue([for value in azurerm_monitor_diagnostic_setting.this : tolist(value.enabled_log)[*].category == tolist(["StorageDelete", "StorageRead", "StorageWrite"])])
    error_message = "Diagnostic setting should have \"StorageRead\", \"StorageWrite\" and \"StorageDelete\" log categories enabled by default"
  }

  assert {
    condition     = alltrue([for value in azurerm_monitor_diagnostic_setting.this : length(value.enabled_metric) == 0])
    error_message = "Diagnostic setting should not have any metric categories enabled by default"
  }
}
