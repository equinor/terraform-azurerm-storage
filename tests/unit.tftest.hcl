mock_provider "azurerm" {}

run "standard_gpv2_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  assert {
    condition     = module.storage.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "standard_blob_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Standard"
    account_kind   = "BlobStorage"
    is_hns_enabled = false
  }

  assert {
    condition     = module.storage.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "BlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "standard_data_lake_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Standard"
    account_kind   = "StorageV2"
    is_hns_enabled = true
  }

  assert {
    condition     = module.storage.account_tier == "Standard"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == true
    error_message = "Hierarchical namespace (HNS) disabled"
  }
}

run "premium_gpv2_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Premium"
    account_kind   = "StorageV2"
    is_hns_enabled = false
  }

  assert {
    condition     = module.storage.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "StorageV2"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "premium_file_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Premium"
    account_kind   = "FileStorage"
    is_hns_enabled = false
  }

  assert {
    condition     = module.storage.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "FileStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}

run "premium_data_lake_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Premium"
    account_kind   = "BlockBlobStorage"
    is_hns_enabled = true
  }

  assert {
    condition     = module.storage.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "BlockBlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == true
    error_message = "Hierarchical namespace (HNS) disabled"
  }
}

run "premium_block_blob_storage" {
  command = plan

  module {
    source = "./tests/setup"
  }

  variables {
    account_tier   = "Premium"
    account_kind   = "BlockBlobStorage"
    is_hns_enabled = false
  }

  assert {
    condition     = module.storage.account_tier == "Premium"
    error_message = "Invalid Storage account tier"
  }

  assert {
    condition     = module.storage.account_kind == "BlockBlobStorage"
    error_message = "Invalid Storage account kind"
  }

  assert {
    condition     = module.storage.is_hns_enabled == false
    error_message = "Hierarchical namespace (HNS) enabled"
  }
}
