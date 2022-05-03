variable "role_list" {
  description = "List of object ID's"
  type        = string
  default     = ("25d23649-cc47-49fa-bfd8-12acafc353a2")
}

variable "location" {
  description = "Specifies the supported Azure location where the resources exist."
  type        = string
  default     = "northeurope"
}

variable "storage_account_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "blob_data_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "blob_data_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "queue_data_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "queue_data_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "table_data_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "table_data_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "smb_share_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "smb_share_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}
