variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "description" {
  description = "description of the role"
  type        = string
}

variable "max_session_duration" {
  description = "maximum duration in seconds for role, between 1 to 12 hours"
  type        = number
  default     = 3600
}

variable "group_names" {
  description = "list of groups that can assume this role"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "name of the role in aws console"
  type        = string
}

variable "path" {
  description = "path of the role in aws console"
  type        = string
  default     = "/"
}

variable "custom_policy" {
  description = "custom policy to be applied to role using the EOF syntax"
  type        = string
  default     = ""
}

variable "attach_policies" {
  description = "map(string) of existing policies to attach"
  type        = map(string)
  default     = {}
}