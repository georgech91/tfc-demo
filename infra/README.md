### Enable Google Cloud APIs
  - Identity and Access Management (IAM) API
  - Artifact Registry API
### Create custom iam roles
1. Go to IAM & Admin > Roles
2. Click Create Role
3. Enter
  - Title: Artifact Registry Repository IAM Writer
  - Description: Artifact Registry Repository IAM Writer
  - ID: artifactregistry.repoiamwriter
4. Add permissions
  - artifactregistry.repositories.get
  - artifactregistry.repositories.getIamPolicy
  - artifactregistry.repositories.setIamPolicy
5. Click Create
### Setup Terraform Service Account
1. Go to IAM & Admin > IAM
2. Click Add
3. Create a principal like 'terraform' and add following roles
  - IAM Workload Identity Pool Admin
  - Service Account Admin
  - Artifact Registry Repository Administrator
  - Artifact Registry Repository IAM Writer
  

