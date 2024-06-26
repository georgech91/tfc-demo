project_id                         = "fluent-potion-419017"
workload_identity_pool_id          = "github-pool"
workload_identity_pool_provider_id = "github"
service_account_id                 = "github"
docker_repo_location               = "northamerica-northeast2"
app_image                          = "northamerica-northeast2-docker.pkg.dev/fluent-potion-419017/docker/go-greet:v0.5.0"
subnet_region                      = "northamerica-northeast2"
subnet_range                       = "10.0.1.0/24"
app_port                           = "8000"
app_zone                           = "northamerica-northeast2-a"