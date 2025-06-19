locals {
  company     = var.company 
  name        = var.name 
  environment = var.environment 
  location    = var.location 
  create_resource_group = var.create_resource_group 
  common_tags = var.common_tags
}

resource "azurerm_resource_group" "apim" {
  count = local.create_resource_group ? 1 : 0 
  name     = "rg-${local.company}-${local.name}-${local.environment}" 
  location = local.location 
}

resource "azurerm_api_management" "apim" {
  name                = "apim-${local.company}-${local.name}-${local.environment}"
  location            = local.location
  resource_group_name = azurerm_resource_group.apim[0].name
  publisher_name      = "Kaopanwa Co., Ltd."
  publisher_email     = "morakot.i@kaopanwa.co.th"
  sku_name            = "Consumption_0"
  tags                = merge( local.common_tags,{})
}