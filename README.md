Terraform Starter Pack
AWS Infrastructure as Terraform scripts

## Running the Code
```bash
# Copy the terraform.tfvars.example to terraform.tfvars
cp terraform.tfvars.example terraform.tfvars

# Enter the correct credentials in terraform.tfvars

# To initialize a module 
terraform init

# To plan changes
terraform plan -var-file=terraform.tfvars

# To apply your changes to the infrastructure
terraform apply -var-file=terraform.tfvars

# To plan on destroying your infrastructure
terraform plan -destroy -var-file=terraform.tfvars

# To destroy your infrastucture
terraform destroy -var-file=terraform.tfvars
