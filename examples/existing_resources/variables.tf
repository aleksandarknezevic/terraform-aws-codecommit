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