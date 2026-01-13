# Module Web App - App Service Plan + Web App

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku

  tags = var.tags
}

# Web App (App Service)
resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    # Configuration minimale
    always_on = false
  }

  tags = var.tags
}
