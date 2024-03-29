org_name                             = "georg"
workspace_name                       = "tfc-demo"
workspace_vcs_repo_branch            = "main"
workspace_vcs_repo_identifier        = "georgech91/tfc-demo"
workspace_vcs_repo_working_directory = "./infra"
project_name                         = "tfc-demo"
service_provider                     = "github"
workspace_variables = [
  {
    key       = "example-tf-key",
    value     = "example-tf-value",
    category  = "terraform",
    sensitive = false
  },
  {
    key       = "EXAMPLE_ENV_key",
    value     = "example-env-value",
    category  = "env",
    sensitive = false
  },
]