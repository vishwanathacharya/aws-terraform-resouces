# AWS Terraform Resources

This repository contains Terraform configurations for AWS infrastructure provisioning with CI/CD pipeline.

## Structure

```
├── environments/
│   ├── production/     # Production environment
│   └── staging/        # Staging environment
└── .github/workflows/  # GitHub Actions CI/CD
```

## Environments

- **Staging**: Deploys when code is pushed to `staging` branch
- **Production**: Deploys when code is pushed to `main` branch

## Setup

1. Add GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. S3 Backend:
   - Bucket: `webkulterraformtfstate`
   - Region: `ap-southeast-2`

## Usage

### Staging Deployment
```bash
git checkout staging
git push origin staging
```

### Production Deployment
```bash
git checkout main
git push origin main
```

## Resources Created

- EC2 Instance (web server)
- S3 Bucket (application storage)
- Tags for environment identification

## State Management

Terraform state files are stored in S3:
- Production: `s3://webkulterraformtfstate/production/terraform.tfstate`
- Staging: `s3://webkulterraformtfstate/staging/terraform.tfstate`
