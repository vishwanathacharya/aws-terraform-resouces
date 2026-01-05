#!/bin/bash

# Terraform Destroy Script
# Usage: ./destroy.sh [staging|production]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if environment is provided
if [ $# -eq 0 ]; then
    print_error "Environment not specified!"
    echo "Usage: $0 [staging|production]"
    exit 1
fi

ENVIRONMENT=$1

# Validate environment
if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "production" ]]; then
    print_error "Invalid environment: $ENVIRONMENT"
    echo "Valid environments: staging, production"
    exit 1
fi

print_warning "⚠️  WARNING: This will DESTROY all resources in $ENVIRONMENT environment!"
print_warning "This action cannot be undone!"
echo ""

# Confirmation prompt
read -p "Type 'DESTROY' to confirm: " confirmation

if [ "$confirmation" != "DESTROY" ]; then
    print_error "Destruction cancelled."
    exit 1
fi

print_status "Starting destruction of $ENVIRONMENT environment..."

# Create backend configuration
print_status "Creating backend configuration..."
cat > backend.tf << EOF
terraform {
  backend "s3" {
    bucket = "webkulterraformtfstate"
    key    = "$ENVIRONMENT/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
EOF

# Create terraform.tfvars
print_status "Creating terraform.tfvars..."
cat > terraform.tfvars << EOF
environment = "$ENVIRONMENT"
EOF

# Initialize Terraform
print_status "Initializing Terraform..."
terraform init

# Plan destroy
print_status "Planning destruction..."
terraform plan -destroy -var-file="terraform.tfvars"

echo ""
print_warning "Last chance to cancel!"
read -p "Proceed with destruction? (yes/no): " final_confirm

if [ "$final_confirm" != "yes" ]; then
    print_error "Destruction cancelled."
    exit 1
fi

# Execute destroy
print_status "Destroying resources..."
terraform destroy -auto-approve -var-file="terraform.tfvars"

# Cleanup temporary files
print_status "Cleaning up temporary files..."
rm -f backend.tf terraform.tfvars

print_status "✅ $ENVIRONMENT environment destroyed successfully!"
print_warning "State file remains in S3 for audit purposes."
