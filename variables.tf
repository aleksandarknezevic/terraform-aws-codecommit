# General variables
variable "enabled" {
  type        = bool
  default     = true
  description = "Enable creation of module."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{'Project': 'XYZ'}`)."
}

# CodeCommit variables
variable "repository_default_branch" {
  type        = string
  default     = ""
  description = "CodeCommit repository default branch"
}

variable "repository_description" {
  type        = string
  default     = ""
  description = "Short description of the CodeCommit repository"

  validation {
    condition     = length(var.repository_description) < 1000
    error_message = "Description for the repository needs to be less than 1000 characters."
  }
}

variable "repository_name" {
  type        = string
  description = "CodeCommit repository name"

  validation {
    condition     = length(var.repository_name) < 100 && length(var.repository_name) > 0
    error_message = "Name for the repository needs to be between 1 and 100 characters."
  }
}

# CodeGuru variables
variable "enable_codeguru" {
  type        = bool
  default     = false
  description = "Whether to enable CodeGuru reviewer"
}

variable "kms_id" {
  type        = string
  default     = ""
  description = "ID for existing KMS for CodeGuru repository association encryption. If `enable_codeguru` is not set, this value will be ignored. If `enable_codeguru` is set and this variable omitted, new KMS key will be created and used."
}

# Notifications variables
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
    codecommit-repository-comments-on-commits,
    codecommit-repository-comments-on-pull-requests,
    codecommit-repository-approvals-status-changed,
    codecommit-repository-approvals-rule-override,
    codecommit-repository-pull-request-created,
    codecommit-repository-pull-request-source-updated,
    codecommit-repository-pull-request-status-change.
  EOF

  validation {
    condition = length(var.notifications_event_ids) == length(distinct(var.notifications_event_ids)) && alltrue([for event in var.notifications_event_ids : contains(["codecommit-repository-comments-on-commits", "codecommit-repository-comments-on-pull-requests", "codecommit-repository-approvals-status-changed", "codecommit-repository-approvals-rule-override", "codecommit-repository-pull-request-created", "codecommit-repository-pull-request-source-updated", "codecommit-repository-pull-request-status-changed"], event)])

    error_message = <<EOF
      The "notifications_events" variable must contain unique elements and all elements must be one of the allowed values:
      - codecommit-repository-comments-on-commits
      - codecommit-repository-comments-on-pull-requests
      - codecommit-repository-approvals-status-changed
      - codecommit-repository-approvals-rule-override
      - codecommit-repository-pull-request-created
      - codecommit-repository-pull-request-source-updated
      - codecommit-repository-pull-request-status-changed
    EOF
  }
}

variable "notifications_topic_arn" {
  type        = string
  default     = ""
  description = "ARN of existing SNS Topic which should be target for notification rule. If not set and variable notifications_enabled is set, new topic will be created"
}
