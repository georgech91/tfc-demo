module "create-workspace" {
  source                               = "app.terraform.io/georg/create-workspace/tfe"
  version                              = "1.0.3"
  org_name                             = var.org_name
  project_name                         = var.project_name
  service_provider                     = var.service_provider
  workspace_name                       = var.workspace_name
  workspace_variables                  = var.workspace_variables
  workspace_vcs_repo_branch            = var.workspace_vcs_repo_branch
  workspace_vcs_repo_identifier        = var.workspace_vcs_repo_identifier
  workspace_vcs_repo_working_directory = var.workspace_vcs_repo_working_directory
  tags_regex                           = var.tags_regex
}