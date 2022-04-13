locals {
  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}
