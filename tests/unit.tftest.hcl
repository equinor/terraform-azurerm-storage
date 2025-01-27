mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "standard_gpv2_storage" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
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
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
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
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Standard"
    account_kind   = "StorageV2"
    is_hns_enabled = true
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

  assert {
    condition     = azurerm_storage_account.this.sftp_enabled == false
    error_message = "SSH File Transfer Protocol (SFTP) enabled"
  }
}

run "premium_gpv2_storage" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Premium"
    account_kind   = "StorageV2"
    is_hns_enabled = false
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
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Premium"
    account_kind   = "FileStorage"
    is_hns_enabled = false
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
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Premium"
    account_kind   = "BlockBlobStorage"
    is_hns_enabled = true
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

  assert {
    condition     = azurerm_storage_account.this.sftp_enabled == false
    error_message = "SSH File Transfer Protocol (SFTP) enabled"
  }
}

run "premium_block_blob_storage" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Premium"
    account_kind   = "BlockBlobStorage"
    is_hns_enabled = false
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

run "network_rules_enabled" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    network_rules_default_action = "Deny"
  }

  assert {
    condition     = length(azurerm_storage_account.this.network_rules) == 1
    error_message = "Network rules block not created when it should have been"
  }

  assert {
    condition     = try(azurerm_storage_account.this.network_rules[0].default_action, null) == "Deny"
    error_message = "Invalid network rules default action"
  }

  assert {
    condition     = azurerm_storage_account.this.network_rules[0].bypass == toset(["AzureServices"])
    error_message = "Invalid network rules bypass"
  }
}

run "network_rules_disabled" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    network_rules_default_action = "Allow"
  }

  assert {
    condition     = length(azurerm_storage_account.this.network_rules) == 0
    error_message = "Network rules block created when it should not have been"
  }
}

run "public_network_access_enabled" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = azurerm_storage_account.this.public_network_access_enabled == true
    error_message = "Invalid Storage account public network access"
  }
}

run "public_network_access_disabled" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    public_network_access_enabled = false
  }

  assert {
    condition     = azurerm_storage_account.this.public_network_access_enabled == false
    error_message = "Invalid Storage account public network access"
  }
}

run "network_rules_bypass_none" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    network_rules_bypass_azure_services = false
  }

  assert {
    condition     = length(azurerm_storage_account.this.network_rules) == 1
    error_message = "Network rules block not created when it should have been"
  }

  assert {
    condition     = azurerm_storage_account.this.network_rules[0].bypass == toset(["None"])
    error_message = "Invalid network rules bypass"
  }
}

run "sftp_enabled" {
  command = plan

  variables {
    account_name               = run.setup_tests.account_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    account_tier   = "Standard"
    account_kind   = "StorageV2"
    is_hns_enabled = true
    sftp_enabled   = true
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

  assert {
    condition     = azurerm_storage_account.this.sftp_enabled == true
    error_message = "SSH File Transfer Protocol (SFTP) disabled"
  }
}
