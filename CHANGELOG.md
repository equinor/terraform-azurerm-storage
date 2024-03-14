# Changelog

## [12.4.0](https://github.com/equinor/terraform-azurerm-storage/compare/v12.3.0...v12.4.0) (2024-03-14)


### Features

* add diagnostic setting name variable ([#210](https://github.com/equinor/terraform-azurerm-storage/issues/210)) ([b5e2ddd](https://github.com/equinor/terraform-azurerm-storage/commit/b5e2dddcd77115209aecbce04441cbff8414103d))
* disable metrics by default ([#202](https://github.com/equinor/terraform-azurerm-storage/issues/202)) ([bbaf7e1](https://github.com/equinor/terraform-azurerm-storage/commit/bbaf7e10f69f4a8bf18b7fdcc018b24c8bb202e3))
* lower default delete retention policies ([#205](https://github.com/equinor/terraform-azurerm-storage/issues/205)) ([dd0780f](https://github.com/equinor/terraform-azurerm-storage/commit/dd0780f4386da768f9565842ea5cfe6f36dd6d16))


### Bug Fixes

* only configure access tier for supported account kinds ([#206](https://github.com/equinor/terraform-azurerm-storage/issues/206)) ([6d88ff6](https://github.com/equinor/terraform-azurerm-storage/commit/6d88ff6673d4228e785042ceb711e4a68ae35203))

## [12.3.0](https://github.com/equinor/terraform-azurerm-storage/compare/v12.2.1...v12.3.0) (2024-01-17)


### Features

* default to OAuth authentication ([#193](https://github.com/equinor/terraform-azurerm-storage/issues/193)) ([996ea93](https://github.com/equinor/terraform-azurerm-storage/commit/996ea9379269ef7e71698847f8a27ec18c8995b7))
* disable advanced threat protection ([#194](https://github.com/equinor/terraform-azurerm-storage/issues/194)) ([48d25f4](https://github.com/equinor/terraform-azurerm-storage/commit/48d25f476a3f1ca247bdd1a9e1947e86d960adb0)), closes [#192](https://github.com/equinor/terraform-azurerm-storage/issues/192)

## [12.2.1](https://github.com/equinor/terraform-azurerm-storage/compare/v12.2.0...v12.2.1) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#187](https://github.com/equinor/terraform-azurerm-storage/issues/187)) ([829a14c](https://github.com/equinor/terraform-azurerm-storage/commit/829a14c27461386eb14b6eb46632baa6f6baa9e4))
* restore accidentally removed blocks ([#191](https://github.com/equinor/terraform-azurerm-storage/issues/191)) ([a61d076](https://github.com/equinor/terraform-azurerm-storage/commit/a61d076f37565642aab7818fdb998c5dc576bf2e))

## [12.2.0](https://github.com/equinor/terraform-azurerm-storage/compare/v12.1.1...v12.2.0) (2023-12-06)


### Features

* enable access tracking ([#183](https://github.com/equinor/terraform-azurerm-storage/issues/183)) ([2dfb352](https://github.com/equinor/terraform-azurerm-storage/commit/2dfb35245fb35ffadf9251e3093c04bc558629ce))

## [12.1.1](https://github.com/equinor/terraform-azurerm-storage/compare/v12.1.0...v12.1.1) (2023-10-04)


### Bug Fixes

* validate network IP rules ([#177](https://github.com/equinor/terraform-azurerm-storage/issues/177)) ([39ea0d5](https://github.com/equinor/terraform-azurerm-storage/commit/39ea0d5fb2c01be7c0eb093abd2516b0c3d0fcd0))

## [12.1.0](https://github.com/equinor/terraform-azurerm-storage/compare/v12.0.0...v12.1.0) (2023-09-04)


### Features

* set network rules default action ([#175](https://github.com/equinor/terraform-azurerm-storage/issues/175)) ([db60d42](https://github.com/equinor/terraform-azurerm-storage/commit/db60d4294fa077029cc1747195cef959c909e8d4))


### Bug Fixes

* correct variable name typo ([#174](https://github.com/equinor/terraform-azurerm-storage/issues/174)) ([6381413](https://github.com/equinor/terraform-azurerm-storage/commit/638141311b16edc82599211a32761114ad6281d5))

## [12.0.0](https://github.com/equinor/terraform-azurerm-storage/compare/v11.0.0...v12.0.0) (2023-07-26)


### ⚠ BREAKING CHANGES

* remove queue properties logging and metrics ([#172](https://github.com/equinor/terraform-azurerm-storage/issues/172))
* enforce blob properties ([#169](https://github.com/equinor/terraform-azurerm-storage/issues/169))
* simplify network configuration ([#166](https://github.com/equinor/terraform-azurerm-storage/issues/166))
* enforce share properties ([#171](https://github.com/equinor/terraform-azurerm-storage/issues/171))
* enforce advanced treat protection ([#167](https://github.com/equinor/terraform-azurerm-storage/issues/167))
* remove variable `identity`, add variables `system_assigned_identity_enabled` and `identity_ids`.

### Features

* enforce advanced treat protection ([#167](https://github.com/equinor/terraform-azurerm-storage/issues/167)) ([09f0b36](https://github.com/equinor/terraform-azurerm-storage/commit/09f0b36b3d16ca9df51c569d0cc0051ed9e8cb6a)), closes [#163](https://github.com/equinor/terraform-azurerm-storage/issues/163)
* enforce blob properties ([#169](https://github.com/equinor/terraform-azurerm-storage/issues/169)) ([7b42e44](https://github.com/equinor/terraform-azurerm-storage/commit/7b42e44ade80330e76ec09588e8b7e16fcba716f))
* enforce share properties ([#171](https://github.com/equinor/terraform-azurerm-storage/issues/171)) ([e6fb81b](https://github.com/equinor/terraform-azurerm-storage/commit/e6fb81b3f575a2e39082a52f3c94951fb0a2ead6)), closes [#168](https://github.com/equinor/terraform-azurerm-storage/issues/168)
* remove queue properties logging and metrics ([#172](https://github.com/equinor/terraform-azurerm-storage/issues/172)) ([0cc0e7f](https://github.com/equinor/terraform-azurerm-storage/commit/0cc0e7f127e35cef663e57141e4832f45124e3a4)), closes [#127](https://github.com/equinor/terraform-azurerm-storage/issues/127)


### Bug Fixes

* don't specify Log Analytics destination type ([#161](https://github.com/equinor/terraform-azurerm-storage/issues/161)) ([8d94fed](https://github.com/equinor/terraform-azurerm-storage/commit/8d94fed5fc197d64cfbe7cd2ad5e31d117cda612))


### Code Refactoring

* simplify identity configuration ([#165](https://github.com/equinor/terraform-azurerm-storage/issues/165)) ([3bc5aee](https://github.com/equinor/terraform-azurerm-storage/commit/3bc5aee844d813d32be85afc840c8ef34c988382))
* simplify network configuration ([#166](https://github.com/equinor/terraform-azurerm-storage/issues/166)) ([64f6b7e](https://github.com/equinor/terraform-azurerm-storage/commit/64f6b7e704b985b073c30fd65fa49e910acfdfcb))

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
