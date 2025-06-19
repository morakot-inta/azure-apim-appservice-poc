locals {
  subscription_name = "poc100"
  backend_storage_account_name ="samatactlapimtfstate"
  backend_resource_group_name = "rg-matactl-apim-tfstate" 
  subscription_id = read_terragrunt_config(find_in_parent_folders("subscription.hcl")).locals.subscription_id 
}

inputs = {
  company     = "matactl"
  name        = "ionos"
  environment = "poc"
  location    = "southeastasia" 
  resource_group_create = true

  common_tags = {
    "Environment" = "poc"
    "Project"     = "poc apim"
    "Owner"       = "morakot.i@kaopanwa.co.th"
  }
}

#  Generate Azure provider
generate "versions" {
  path = "version_override.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = ">= 3.51, < 4.0"
      }
    }
  }
    provider "azurerm" {
        features {}
        subscription_id = "${local.subscription_id}"
    }
EOF
}

remote_state {
  backend = "azurerm"
  config = {
    subscription_id = local.subscription_id
    resource_group_name = local.backend_resource_group_name 
    storage_account_name = local.backend_storage_account_name 
    container_name       = "tfstate"
    key                  = "${get_path_from_repo_root()}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}