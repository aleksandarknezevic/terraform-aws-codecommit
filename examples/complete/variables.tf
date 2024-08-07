variable "region" {
  type        = string
  description = "AWS region"
}

variable "repository_description" {
  type        = string
  default     = ""
  description = "Short description of the CodeCommit repository"
}

variable "repository_name" {
  type        = string
  description = "CodeCommit repository name"
}

variable "repository_default_branch" {
  type        = string
  description = "CodeCommit repository default branch"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{'Project': 'XYZ'}`)."
}

variable "enable_codeguru" {
  type        = bool
  default     = false
  description = "Whether to enable CodeGuru reviewer"
}

variable "notifications_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable CodeCommit notifications"
}

variable "notifications_detail_type" {
  type        = string
  default     = "FULL"
  description = "Notifications detail types (\"FULL\" or \"BASIC\")"

  validation {
    condition     = var.notifications_detail_type == "FULL" || var.notifications_detail_type == "BASIC"
    error_message = "Variable notifications_detail_types must have one of these values: FULL or BASIC."
  }
}

variable "notifications_event_ids" {
  type = list(string)
  default = ["codecommit-repository-comments-on-commits", "codecommit-repository-comments-on-pull-requests",
    "codecommit-repository-approvals-status-changed", "codecommit-repository-approvals-rule-override",
  "codecommit-repository-pull-request-created", "codecommit-repository-pull-request-source-updated", "codecommit-repository-pull-request-status-changed"]
  description = <<EOF
    List of notifications events. Allowed values are:
    - codecommit-repository-comments-on-commits
    - codecommit-repository-comments-on-pull-requests
    - codecommit-repository-approvals-status-changed
    - codecommit-repository-approvals-rule-override
    - codecommit-repository-pull-request-created
    - codecommit-repository-pull-request-source-updated
    - codecommit-repository-pull-request-status-change
  EOF

  validation {
    condition     = length(var.notifications_event_ids) == length(distinct(var.notifications_event_ids)) && alltrue([for event in var.notifications_event_ids : contains(["codecommit-repository-comments-on-commits", "codecommit-repository-comments-on-pull-requests", "codecommit-repository-approvals-status-changed", "codecommit-repository-approvals-rule-override", "codecommit-repository-pull-request-created", "codecommit-repository-pull-request-source-updated", "codecommit-repository-pull-request-status-changed"], event)])
    error_message = "The 'notifications_events' variable must contain unique elements and all elements must be one of the allowed values: codecommit-repository-comments-on-commits, codecommit-repository-comments-on-pull-requests, codecommit-repository-approvals-status-changed, codecommit-repository-approvals-rule-override, codecommit-repository-pull-request-created, codecommit-repository-pull-request-source-updated, codecommit-repository-pull-request-status-change."

  }
}
