output "repository_id" {
  value       = aws_codecommit_repository.this[*].repository_id
  description = "CodeCommit repository ID"
}

output "repository_arn" {
  value       = aws_codecommit_repository.this[*].arn
  description = "CodeCommit repository ARN"
}

output "repository_clone_url_http" {
  value       = aws_codecommit_repository.this[*].clone_url_http
  description = "CodeCommit repository HTTP clone url"
}

output "repository_clone_url_ssh" {
  value       = aws_codecommit_repository.this[*].clone_url_ssh
  description = "CodeCommit repository SSH clone url"
}

output "repository_default_branch" {
  value       = var.repository_default_branch != "" ? var.repository_default_branch : "main"
  description = "CodeCommit repository's default branch"
}

output "codegurureviewer_repository_association" {
  value = aws_codegurureviewer_repository_association.this[*].id
}

output "notifications_sns_arn" {
  value       = var.notifications_enabled ? var.notifications_topic_arn != "" ? var.notifications_topic_arn : aws_codestarnotifications_notification_rule.this[0].arn : null
  description = "ARN of SNS topic for notifications (if enabled)"
}