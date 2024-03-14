variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "account_kind" {
  type    = string
  default = null
}

variable "account_tier" {
  type    = string
  default = null
}

variable "is_hns_enabled" {
  type    = bool
  default = null
}
