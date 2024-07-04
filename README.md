# terraform-aws-codecommit
Terraform module for AWS CodeCommit

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.59 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.59 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codecommit_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_codegurureviewer_repository_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codegurureviewer_repository_association) | resource |
| [aws_codestarnotifications_notification_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarnotifications_notification_rule) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_codeguru"></a> [enable\_codeguru](#input\_enable\_codeguru) | Whether to enable CodeGuru reviewer | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable creation of module. | `bool` | `true` | no |
| <a name="input_kms_id"></a> [kms\_id](#input\_kms\_id) | ID for existing KMS for CodeGuru repository association encryption. If `enable_codeguru` is not set, this value will be ignored. If `enable_codeguru` is set and this variable omitted, new KMS key will be created and used. | `string` | `""` | no |
| <a name="input_notifications_detail_type"></a> [notifications\_detail\_type](#input\_notifications\_detail\_type) | Notifications detail types ("FULL" or "BASIC") | `string` | `"FULL"` | no |
| <a name="input_notifications_enabled"></a> [notifications\_enabled](#input\_notifications\_enabled) | Whether to enable CodeCommit notifications | `bool` | `false` | no |
| <a name="input_notifications_event_ids"></a> [notifications\_event\_ids](#input\_notifications\_event\_ids) | List of notifications events. Allowed values are:<br>    - codecommit-repository-comments-on-commits<br>    - codecommit-repository-comments-on-pull-requests<br>    - codecommit-repository-approvals-status-changed<br>    - codecommit-repository-approvals-rule-override<br>    - codecommit-repository-pull-request-created<br>    - codecommit-repository-pull-request-source-updated<br>    - codecommit-repository-pull-request-status-change | `list(string)` | <pre>[<br>  "codecommit-repository-comments-on-commits",<br>  "codecommit-repository-comments-on-pull-requests",<br>  "codecommit-repository-approvals-status-changed",<br>  "codecommit-repository-approvals-rule-override",<br>  "codecommit-repository-pull-request-created",<br>  "codecommit-repository-pull-request-source-updated",<br>  "codecommit-repository-pull-request-status-changed"<br>]</pre> | no |
| <a name="input_notifications_topic_arn"></a> [notifications\_topic\_arn](#input\_notifications\_topic\_arn) | ARN of existing SNS Topic which should be target for notification rule. If not set and variable notifications\_enabled is set, new topic will be created | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_repository_default_branch"></a> [repository\_default\_branch](#input\_repository\_default\_branch) | CodeCommit repository default branch | `string` | `""` | no |
| <a name="input_repository_description"></a> [repository\_description](#input\_repository\_description) | Short description of the CodeCommit repository | `string` | `""` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | CodeCommit repository name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'Project': 'XYZ'}`). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codegurureviewer_repository_association"></a> [codegurureviewer\_repository\_association](#output\_codegurureviewer\_repository\_association) | CodeGuru Reviewer repository association ID |
| <a name="output_notifications_sns_arn"></a> [notifications\_sns\_arn](#output\_notifications\_sns\_arn) | ARN of SNS topic for notifications (if enabled) |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | CodeCommit repository ARN |
| <a name="output_repository_clone_url_http"></a> [repository\_clone\_url\_http](#output\_repository\_clone\_url\_http) | CodeCommit repository HTTP clone url |
| <a name="output_repository_clone_url_ssh"></a> [repository\_clone\_url\_ssh](#output\_repository\_clone\_url\_ssh) | CodeCommit repository SSH clone url |
| <a name="output_repository_default_branch"></a> [repository\_default\_branch](#output\_repository\_default\_branch) | CodeCommit repository's default branch |
| <a name="output_repository_id"></a> [repository\_id](#output\_repository\_id) | CodeCommit repository ID |
<!-- END_TF_DOCS -->