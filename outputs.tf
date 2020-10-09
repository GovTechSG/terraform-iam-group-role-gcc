output "arn" {
  description = "arn of the role"
  value       = "${aws_iam_role.iam_role.arn}"
}

output "create_date" {
  description = "date which the role was created"
  value       = "${aws_iam_role.iam_role.create_date}"
}

output "description" {
  description = "description of the role"
  value       = "${aws_iam_role.iam_role.description}"
}

output "id" {
  description = "id of the role"
  value       = "${aws_iam_role.iam_role.id}"
}

output "name" {
  description = "name of the role"
  value       = "${aws_iam_role.iam_role.name}"
}

output "policy" {
  description = "policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.policy}"
}

output "policy_arn" {
  description = "arn of policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.arn}"
}

output "policy_description" {
  description = "description of policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.description}"
}

output "policy_id" {
  description = "id of policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.id}"
}

output "policy_name" {
  description = "name of policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.name}"
}

output "policy_path" {
  description = "path of policy attached to this role"
  value       = "${aws_iam_policy.iam_allowing_group_to_assume_role.path}"
}

output "trust_policy" {
  description = "trust role policy of this role"
  value       = "${data.aws_iam_policy_document.iam_trusted.json}"
}

output "unique_id" {
  description = "unique id of the role"
  value       = "${aws_iam_role.iam_role.unique_id}"
}

output "role_session_duration" {
  description = "maximum duration a role can be assume for"
  value       = "${aws_iam_role.iam_role.max_session_duration}"
}