variable "role_list" {
  description = "List of object ID's"
  type        = list(string)
  default     = []
}

variable "location" {
  description = "Specifies the supported Azure location where the resources exist."
  type        = string
  default     = "northeurope"
}

variable "account_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "blob_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "blob_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "queue_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "queue_reader" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "table_contributor" {
  description = "The ID's of the Principals that should be able to read and assign the User Assigned Identity."
  type        = list(string)
  default     = []
}

variable "table_reader" {
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
