run "standard_gpv2_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/standard-gpv2-storage"
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

run "standard_blob_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/standard-blob-storage"
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

run "standard_data_lake_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/standard-data-lake-storage"
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

run "premium_gpv2_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/premium-gpv2-storage"
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

run "premium_file_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/premium-file-storage"
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

run "premium_data_lake_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/premium-data-lake-storage"
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

run "premium_block_blob_storage_unit_tests" {
  command = plan

  module {
    source = "./examples/premium-block-blob-storage"
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

run "cmk_unit_tests" {
  command = plan

  module {
    source = "./examples/cmk"
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
