# AWS Terraform Resources

This repository contains Terraform configurations for AWS infrastructure provisioning with CI/CD pipeline.

## Structure

```
├── main.tf              # Common resources
├── variables.tf         # Input variables
├── provider.tf          # AWS provider config
├── outputs.tf           # Output values
├── destroy.sh           # Local destroy script
├── backend.tf           # Created dynamically per branch
└── .github/workflows/   # GitHub Actions CI/CD
    ├── terraform.yml    # Deploy workflow
    └── destroy.yml      # Destroy workflow
```

## Branch Strategy

- **main**: Common Terraform code (no environment-specific configs)
- **live**: Triggers production deployment with production backend
- **stage**: Triggers staging deployment with staging backend

## How It Works

1. **Main Branch**: Contains common Terraform code
2. **Live/Stage Branches**: Pipeline creates environment-specific configs:
   - `backend.tf` with appropriate S3 state path
   - `terraform.tfvars` with environment variable

## Setup

1. Add GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. S3 Backend:
   - Bucket: `webkulterraformtfstate`
   - Region: `ap-southeast-1`

## Usage

### Stage Environment Deployment
```bash
git checkout -b stage
git push origin stage
```

### Live Environment Deployment
```bash
git checkout -b live
git push origin live
```

### Code Updates (No Deployment)
```bash
git checkout main
git push origin main  # Only stores code, no pipeline
```

## Destroy Resources

### Method 1: GitHub Actions (Recommended)
1. Go to Actions tab in GitHub
2. Select "Terraform Destroy" workflow
3. Click "Run workflow"
4. Select environment (staging/production)
5. Type "DESTROY" to confirm

### Method 2: Local Script
```bash
# Destroy staging environment
./destroy.sh staging

# Destroy production environment
./destroy.sh production
```

## Resources Created

- EC2 Instance (web server)
  - Production: t3.medium
  - Staging: t2.micro
- Environment-specific tags

## State Management

Terraform state files are stored in S3:
- Live: `s3://webkulterraformtfstate/production/terraform.tfstate`
- Stage: `s3://webkulterraformtfstate/staging/terraform.tfstate`

## Pipeline Behavior

- **main branch**: No pipeline execution, code storage only
- **live branch**: Creates production configs and deploys
- **stage branch**: Creates staging configs and deploys
- **destroy workflow**: Manual trigger to destroy resources
