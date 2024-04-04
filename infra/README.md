### Enable Google Cloud APIs
  - Identity and Access Management (IAM) API
  - Artifact Registry API
  - Compute Engine API
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
6. Click Create Role
7. Enter
  - Title: Compute Firewall Admin
  - Description: Compute Firewall Admin
  - ID: compute.firewallAdmin
8. Add permissions
  - compute.firewalls.create
  - compute.firewalls.delete
  - compute.firewalls.get
  - compute.firewalls.list
  - compute.firewalls.update
9. Click Create
### Setup Terraform Service Account
1. Go to IAM & Admin > IAM
2. Click Add
3. Create a principal like 'terraform' and add following roles
  - IAM Workload Identity Pool Admin
  - Service Account Admin
  - Artifact Registry Administrator
  - Artifact Registry Repository IAM Writer
  - Compute Instance Admin (v1)
  - Compute Network Admin
  - Compute Firewall Admin
4. Go to IAM & Admin > Service Accounts
5. Click 836223963401-compute@developer.gserviceaccount.com
6. Click Permissions
7. Click Grant Access
8. Enter terraform service account email as principal
9. Add Service Account User role
  

