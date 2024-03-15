provider "azurerm" {
  storage_use_azuread = true

  features {}
}

run "setup_tests" {
  module {
    source = "./tests/setup-integration-tests"
  }
}

run "standard_gpv2_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "standard_blob_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Standard"
    account_kind   = "BlobStorage"
    is_hns_enabled = false
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "BlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "standard_data_lake_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier        = "Standard"
    account_kind        = "StorageV2"
    is_hns_enabled      = true
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == true
    error_message = "Hierarchical namespace (HNS) disabled"
  }
}

run "premium_gpv2_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier        = "Premium"
    account_kind        = "StorageV2"
    is_hns_enabled      = false
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "premium_file_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier        = "Premium"
    account_kind        = "FileStorage"
    is_hns_enabled      = false
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "FileStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "premium_data_lake_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier        = "Premium"
    account_kind        = "BlockBlobStorage"
    is_hns_enabled      = true
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "BlockBlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == true
    error_message = "Hierarchical namespace (HNS) disabled"
  }
}

run "premium_block_blob_storage" {
  variables {
    account_name               = run.setup_tests.account_name
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier        = "Premium"
    account_kind        = "BlockBlobStorage"
    is_hns_enabled      = false
  }

  assert {
    condition     = azurerm_storage_account.this.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = azurerm_storage_account.this.account_kind == "BlockBlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = azurerm_storage_account.this.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}
