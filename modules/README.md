Small project to build out a custom module. Project has this structure;

root/
├── modules/
│   └── lambda/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
├── lambda_function.zip       # Deployment package for the Lambda function
├── resource.tf               # Root configuration calling the module
├── provider.tf               # AWS provider configuration
└── terraform.tfvars          # Optional variables file


modules/lambda/main.tf : file defines the resources created by the module, in this case a lambda, an IAM role and its associated policy. Each argument must be defined as a variable in order to be created as as module
modules/lambda/variables : All arguments required to create aws_lambda_function + role/policy
modules/lambda/output : all outputs required by other resources in dile hierarchy

resource.tf : root level file that creates the bundled resources, defined in modules/lambda, passing in defined args required. This module "lambda-with-role" block must supply a source field, pointing to the modules location.