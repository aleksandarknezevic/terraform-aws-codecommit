resource "aws_kms_key" "this" {
  description = "KMS key for CodeGuru repository association encryption. CodeCommit repository: ${var.repository_name}"
  tags        = var.tags
}

module "codecommit_repository" {
  source = "../../"
  repository_name           = var.repository_name
  repository_description    = var.repository_description
  repository_default_branch = var.repository_default_branch
  enable_codeguru           = var.enable_codeguru
  kms_id                    = aws_kms_key.this.id
  tags                      = var.tags
}