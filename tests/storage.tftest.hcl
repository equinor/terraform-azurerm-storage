run "standard_gpv2_storage_tests" {
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
