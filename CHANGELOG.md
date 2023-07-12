# Changelog

## [11.0.0](https://github.com/equinor/terraform-azurerm-storage/compare/v10.4.0...v11.0.0) (2023-07-12)


### ⚠ BREAKING CHANGES

* enforce network ACLs default action ([#158](https://github.com/equinor/terraform-azurerm-storage/issues/158))

### Features

* enforce network ACLs default action ([#158](https://github.com/equinor/terraform-azurerm-storage/issues/158)) ([572d8ee](https://github.com/equinor/terraform-azurerm-storage/commit/572d8eea8ab1f6361e6fcef54372ca2af9ad0e71))

## [10.4.0](https://github.com/equinor/terraform-azurerm-storage/compare/v10.3.0...v10.4.0) (2023-05-19)


### Features

* disable cross-tenant replication by default ([#156](https://github.com/equinor/terraform-azurerm-storage/issues/156)) ([b254ba0](https://github.com/equinor/terraform-azurerm-storage/commit/b254ba001b5e89cfaf5e1a2c4627303011d2b5fe)), closes [#155](https://github.com/equinor/terraform-azurerm-storage/issues/155)

## [10.3.0](https://github.com/equinor/terraform-azurerm-storage/compare/v10.2.0...v10.3.0) (2023-04-17)


### Features

* output Storage account identity principal ID ([#141](https://github.com/equinor/terraform-azurerm-storage/issues/141)) ([028517e](https://github.com/equinor/terraform-azurerm-storage/commit/028517e113b87652264337455492058b66b5440c))
* set diagnostic setting enabled log categories ([#139](https://github.com/equinor/terraform-azurerm-storage/issues/139)) ([03d13fb](https://github.com/equinor/terraform-azurerm-storage/commit/03d13fbca8c7bf9ddecf6dd2342eb419620b379d))


### Bug Fixes

* don't output non-existent attributes ([#147](https://github.com/equinor/terraform-azurerm-storage/issues/147)) ([c578aa8](https://github.com/equinor/terraform-azurerm-storage/commit/c578aa82f32687f963b1baf6a97afb66bcf86a64))

## [10.2.0](https://github.com/equinor/terraform-azurerm-storage/compare/v10.1.0...v10.2.0) (2023-02-09)


### Features

* set log analytics destination type ([#132](https://github.com/equinor/terraform-azurerm-storage/issues/132)) ([c67ff89](https://github.com/equinor/terraform-azurerm-storage/commit/c67ff892e31501cf32cbde219aaf7e89751b9bc9))


### Bug Fixes

* set log analytics dest type to null ([#134](https://github.com/equinor/terraform-azurerm-storage/issues/134)) ([2dfd09f](https://github.com/equinor/terraform-azurerm-storage/commit/2dfd09fe05366531807d0d823a18f3607e322135))

## [10.1.0](https://github.com/equinor/terraform-azurerm-storage/compare/v10.0.0...v10.1.0) (2023-02-01)


### Features

* set custom domain ([#129](https://github.com/equinor/terraform-azurerm-storage/issues/129)) ([d7c2233](https://github.com/equinor/terraform-azurerm-storage/commit/d7c2233e7053b514831d6baedfe6d3fe0c365653))
* set identity type and ids ([#122](https://github.com/equinor/terraform-azurerm-storage/issues/122)) ([bc5af09](https://github.com/equinor/terraform-azurerm-storage/commit/bc5af0999697cdcb92157f3d9486dcb89aadf39b))

## [10.0.0](https://github.com/equinor/terraform-azurerm-storage/compare/v9.3.0...v10.0.0) (2023-01-20)


### ⚠ BREAKING CHANGES

* rename variables ([#120](https://github.com/equinor/terraform-azurerm-storage/issues/120))

### Code Refactoring

* rename variables ([#120](https://github.com/equinor/terraform-azurerm-storage/issues/120)) ([c30cbb1](https://github.com/equinor/terraform-azurerm-storage/commit/c30cbb156bfd79f52bec5254653d0f7e8674cc83))

## [9.3.0](https://github.com/equinor/terraform-azurerm-storage/compare/v9.2.0...v9.3.0) (2023-01-19)


### Features

* set queue properties ([#101](https://github.com/equinor/terraform-azurerm-storage/issues/101)) ([aaffa6c](https://github.com/equinor/terraform-azurerm-storage/commit/aaffa6cf3f6d83f7cb62215b98617f6e1e3bd611)), closes [#92](https://github.com/equinor/terraform-azurerm-storage/issues/92)
