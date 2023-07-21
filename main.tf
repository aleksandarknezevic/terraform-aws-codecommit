resource "aws_codecommit_repository" "this" {
  count           = var.enabled ? 1 : 0
  repository_name = var.repository_name
  description     = var.repository_description
  default_branch  = var.repository_default_branch != "" ? var.repository_default_branch : null
  tags            = var.tags

  lifecycle {
    ignore_changes = [
      tags["codeguru-reviewer"]
    ]
  }
}

resource "aws_kms_key" "this" {
  count       = var.enabled && var.enable_codeguru && var.kms_id == "" ? 1 : 0
  description = "KMS key for CodeGuru repository association encryption. CodeCommit repository: ${var.repository_name}"
  tags        = var.tags
}

resource "aws_codegurureviewer_repository_association" "this" {
  count = var.enabled && var.enable_codeguru ? 1 : 0

  repository {
    codecommit {
      name = aws_codecommit_repository.this[0].repository_name
    }
  }

  dynamic "kms_key_details" {
    for_each = var.enable_codeguru ? toset([true]) : toset([])
    content {
      encryption_option = "CUSTOMER_MANAGED_CMK"
      kms_key_id        = var.kms_id == "" ? aws_kms_key.this[0].id : var.kms_id
    }
  }

  tags = var.tags
}

resource "aws_sns_topic" "this" {
  count        = var.enabled && var.notifications_enabled && var.notifications_topic_arn == "" ? 1 : 0
  name         = format("%s-notifications", var.repository_name)
  display_name = format("%s-notifications", var.repository_name)

  tags = var.tags
}

data "aws_iam_policy_document" "this" {
  count = var.enabled && var.notifications_enabled && var.notifications_topic_arn == "" ? 1 : 0
  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    resources = [aws_sns_topic.this[0].arn]
  }
}

resource "aws_sns_topic_policy" "this" {
  count  = var.enabled && var.notifications_enabled && var.notifications_topic_arn == "" ? 1 : 0
  arn    = aws_sns_topic.this[0].arn
  policy = data.aws_iam_policy_document.this[0].json
}

resource "aws_codestarnotifications_notification_rule" "this" {
  count          = var.enabled && var.notifications_enabled ? 1 : 0
  detail_type    = var.notifications_detail_type
  event_type_ids = var.notifications_event_ids

  name     = format("%s-notifications", aws_codecommit_repository.this[0].repository_name)
  resource = aws_codecommit_repository.this[0].arn

  target {
    address = var.notifications_topic_arn != "" ? var.notifications_topic_arn : aws_sns_topic.this[0].arn
  }
}