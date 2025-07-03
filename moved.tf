moved {
  from = azurerm_monitor_diagnostic_setting.this["blob"]
  to   = azurerm_monitor_diagnostic_setting.blob
}

moved {
  from = azurerm_monitor_diagnostic_setting.this["queue"]
  to   = azurerm_monitor_diagnostic_setting.queue
}

moved {
  from = azurerm_monitor_diagnostic_setting.this["table"]
  to   = azurerm_monitor_diagnostic_setting.table
}

moved {
  from = azurerm_monitor_diagnostic_setting.this["file"]
  to   = azurerm_monitor_diagnostic_setting.file
}
