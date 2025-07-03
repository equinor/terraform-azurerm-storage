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
    target = azurerm_monitor_diagnostic_setting.blob
    values = {
      log_analytics_destination_type = null
    }
  }

  override_resource {
    target = azurerm_monitor_diagnostic_setting.queue
    values = {
      log_analytics_destination_type = null
    }
  }

  override_resource {
    target = azurerm_monitor_diagnostic_setting.table
    values = {
      log_analytics_destination_type = null
    }
  }

  override_resource {
    target = azurerm_monitor_diagnostic_setting.file
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
    condition = alltrue([
      azurerm_monitor_diagnostic_setting.blob.name == "audit-logs",
      azurerm_monitor_diagnostic_setting.queue.name == "audit-logs",
      azurerm_monitor_diagnostic_setting.table.name == "audit-logs",
      azurerm_monitor_diagnostic_setting.file.name == "audit-logs"
    ])
    error_message = "Diagnostic setting name should be \"audit-logs\" by default"
  }

  assert {
    condition = alltrue([
      azurerm_monitor_diagnostic_setting.blob.target_resource_id == "${azurerm_storage_account.this.id}/blobServices/default",
      azurerm_monitor_diagnostic_setting.queue.target_resource_id == "${azurerm_storage_account.this.id}/queueServices/default",
      azurerm_monitor_diagnostic_setting.table.target_resource_id == "${azurerm_storage_account.this.id}/tableServices/default",
      azurerm_monitor_diagnostic_setting.file.target_resource_id == "${azurerm_storage_account.this.id}/fileServices/default"
    ])
    error_message = "Diagnostic setting should be linked to the Storage account resource"
  }

  assert {
    condition = alltrue([
      azurerm_monitor_diagnostic_setting.blob.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id,
      azurerm_monitor_diagnostic_setting.queue.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id,
      azurerm_monitor_diagnostic_setting.table.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id,
      azurerm_monitor_diagnostic_setting.file.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id
    ])
    error_message = "Diagnostic setting should be linked to the setup test Log Analytics workspace"
  }

  assert {
    condition = alltrue([
      azurerm_monitor_diagnostic_setting.blob.log_analytics_destination_type == null,
      azurerm_monitor_diagnostic_setting.queue.log_analytics_destination_type == null,
      azurerm_monitor_diagnostic_setting.table.log_analytics_destination_type == null,
      azurerm_monitor_diagnostic_setting.file.log_analytics_destination_type == null
    ])
    error_message = "Diagnostic setting should not have a Log Analytics destination type configured for Storage account"
  }

  assert {
    condition = alltrue([
      length(azurerm_monitor_diagnostic_setting.blob.enabled_log) == 3 && tolist(azurerm_monitor_diagnostic_setting.blob.enabled_log)[*].category == tolist(["StorageDelete", "StorageRead", "StorageWrite"]),
      length(azurerm_monitor_diagnostic_setting.queue.enabled_log) == 3 && tolist(azurerm_monitor_diagnostic_setting.queue.enabled_log)[*].category == tolist(["StorageDelete", "StorageRead", "StorageWrite"]),
      length(azurerm_monitor_diagnostic_setting.table.enabled_log) == 3 && tolist(azurerm_monitor_diagnostic_setting.table.enabled_log)[*].category == tolist(["StorageDelete", "StorageRead", "StorageWrite"]),
      length(azurerm_monitor_diagnostic_setting.file.enabled_log) == 3 && tolist(azurerm_monitor_diagnostic_setting.file.enabled_log)[*].category == tolist(["StorageDelete", "StorageRead", "StorageWrite"])
    ])
    error_message = "Diagnostic setting should have \"StorageRead\", \"StorageWrite\" and \"StorageDelete\" log categories enabled by default"
  }

  assert {
    condition = alltrue([
      length(azurerm_monitor_diagnostic_setting.blob.enabled_metric) == 0,
      length(azurerm_monitor_diagnostic_setting.queue.enabled_metric) == 0,
      length(azurerm_monitor_diagnostic_setting.table.enabled_metric) == 0,
      length(azurerm_monitor_diagnostic_setting.file.enabled_metric) == 0
    ])
    error_message = "Diagnostic setting should not have any metric categories enabled by default"
  }
}
