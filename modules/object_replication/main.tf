locals {
  account_name = substr(regex("^[a-z0-9]+$", lower("${var.application}${var.environment}")), 0, 24)
}

resource "azurerm_resource_group" "src" {
  name     = coalesce(var.account_name, "srcrg${local.account_name}")
  location = var.location
}

resource "azurerm_storage_account" "src" {
  name                = coalesce(var.account_name, "st${local.account_name}")
  resource_group_name = azurerm_resource_group.src.name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access

  tags = local.tags
}

resource "azurerm_storage_container" "src" {
  name                  = coalesce(var.account_name, "ci${local.account_name}")
  storage_account_name  = azurerm_storage_account.src.name
  container_access_type = "private"
}

resource "azurerm_resource_group" "dst" {
  name     = coalesce(var.account_name, "dstrg${local.account_name}")
  location = var.location
}

resource "azurerm_storage_account" "dst" {
  name                = coalesce(var.account_name, "st${local.account_name}")
  resource_group_name = azurerm_resource_group.dst.name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access

  tags = local.tags
}

resource "azurerm_storage_container" "dst" {
  name                  = coalesce(var.account_name, "ci${local.account_name}")
  storage_account_name  = azurerm_storage_account.dst.name
  container_access_type = "private"
}

resource "azurerm_storage_object_replication" "this" {
  source_storage_account_id      = azurerm_storage_account.src.id
  destination_storage_account_id = azurerm_storage_account.dst.id

  rules {
    source_container_name      = azurerm_storage_account.src.name
    destination_container_name = azurerm_storage_container.dst.name
  }
}


