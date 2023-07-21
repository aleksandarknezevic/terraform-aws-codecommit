module "codecommit_repository" {
  source = "../../"

  region                    = var.region
  repository_name           = var.repository_name
  repository_description    = var.repository_description
  repository_default_branch = var.repository_default_branch
  enable_codeguru           = var.enable_codeguru
  tags                      = var.tags
  notifications_enabled     = var.notifications_enabled
  notifications_detail_type = var.notifications_detail_type
  notifications_event_ids   = var.notifications_event_ids
}