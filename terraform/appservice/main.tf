locals {
  company     = var.company 
  name        = var.name 
  environment = var.environment 
  location    = var.location 
  common_tags = var.common_tags
  resource_group_name = var.resource_group_name
}


resource "azurerm_service_plan" "this" {
  name = "plan-${local.company}-${local.name}-${local.environment}" 
  resource_group_name = local.resource_group_name 
  location = local.location
  os_type = "Windows"
  sku_name = "P0v3"
}

resource "azurerm_windows_web_app" "this" {
  name = "app-${local.company}-${local.name}-${local.environment}"
  resource_group_name = local.resource_group_name
  location = local.location
  service_plan_id = azurerm_service_plan.this.id
  site_config {
    application_stack {
      dotnet_version = "v8.0"
    } 
      
  }
  app_settings ={
  }

  tags = merge(local.common_tags, {
    "CreatedBy" = "Terraform"
  })

}

# zip file dotnet after build with null resource
resource "null_resource" "zip_file" {
  provisioner "local-exec" {
    command = "cd ~/Documents/poc-apim/sample_code ; dotnet publish -c Release -o publish && cd publish && zip -r ../publish.zip ." 
  }
  depends_on = [azurerm_windows_web_app.this]
}

# deploy zip file to app service with null resource
resource "null_resource" "deploy_zip" {
  provisioner "local-exec" {
    command = "az webapp deploy --resource-group ${local.resource_group_name} --name ${azurerm_windows_web_app.this.name} --src-path ~/Documents/poc-apim/sample_code/publish.zip --type zip"
  }
  depends_on = [null_resource.zip_file]
} 

