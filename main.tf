#
# iam-role
# --------
# this module assists in creating an iam role that enables members of groups listed
# in the `var.group_names` variable to assume it
#

# ref: https://www.terraform.io/docs/providers/aws/d/caller_identity.html
data "aws_caller_identity" "current" {}

# ref: https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
data "aws_iam_policy_document" "iam_trusted" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      # root looks scary but this is just a trust policy so that we can attach the actual
      # policy that allows sts:AssumeRole to be exercised, this alone will not enable anything
      # to assume the role
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    # Only allow role to be assumed if MFA token is present
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "true",
      ]
    }
    condition {
      test = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values = [ "3600" ]
    }
  }
}

# ref: https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
data "aws_iam_policy_document" "iam_rolling" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = formatlist("arn:aws:iam::${data.aws_caller_identity.current.account_id}:group/%s", var.group_names)
    effect    = "Allow"
  }
}

# ref: https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "iam_role" {
  name                  = var.name
  path                  = var.path
  description           = var.description
  permissions_boundary  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/GCCIAccountBoundary"
  assume_role_policy    = data.aws_iam_policy_document.iam_trusted.json
  max_session_duration = var.max_session_duration
  force_detach_policies = true
}

# ref: https://www.terraform.io/docs/providers/aws/r/iam_policy.html
resource "aws_iam_policy" "iam_allowing_group_to_assume_role" {
  name        = "${var.name}-group-enabler"
  description = "allows for groups [${join(",", var.group_names)}] to assume role/${var.name}"
  policy      = data.aws_iam_policy_document.iam_rolling.json
}

# ref: https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
resource "aws_iam_role_policy_attachment" "iam_grouping" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_allowing_group_to_assume_role.arn
}

# Only create the custom inline policy for this role if it's not empty
resource "aws_iam_role_policy" "custom_policy" {
  name   = "custom_policy"
  role   = aws_iam_role.iam_role.name
  count  = var.custom_policy != "" ? 1 : 0
  policy = var.custom_policy
}

# Maps the given list of existing policies to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.iam_role.name
  for_each   = var.attach_policies
  policy_arn = each.value
}