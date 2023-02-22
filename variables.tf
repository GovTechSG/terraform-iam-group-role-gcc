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

variable "identities" {
  description = "list of users that can assume this role, i put map in case next time we need to add more stuff"
  type        = list(map(string))
  default     = [{ "email" = "techpass_user@tech.gov.sg" },{ "email" = "techpass_developer@tech.gov.sg" }]
}

variable "agency_assume_local_role_id" {
  description = "your role_id should be the agency_assume_local role_id, use aws iam list-roles to find out"
  type        = string
  default     = "AROA9BAABCD5NSXYZE123"
}