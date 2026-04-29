variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "DJANGO_SECRET_KEY_PROD" {}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-acmp-final"
    storage_account_name = "acmp2400storageaccount"
    container_name = "big-tf-state-acmp2400"
    key = "braydenward.tfstate"
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features{}
}

resource "azurerm_container_registry" "teacher_acr" {
  name = "acrbrayden2400"
  resource_group_name = "rg-braydenward"
  location = "Central US"
  sku = "Basic"
  admin_enabled = false
}

resource "azurerm_container_group" "aci_brayden_acmp" {
  name = "aci-brayden-acmp"
  resource_group_name = "rg-braydenward"
  location = "Central US"
  ip_address_type = "Public"
  dns_name_label = "acmp-brayden-instance"
  os_type = "Linux"

  container {
  name = "final"
  image = "acrbrayden2400.azurect.io/final:latest"
  cpu = "0.5"
  memory = "1.5"

  ports {
    port = 8000
    protocol = "TCP"
  }

  secure_environment_variables = {
    DJANGO_SECRET_KEY = var.DJANGO_SECRET_KEY_PROD
  }
}

  image_registry_credential {
    server = "arcbrayden2400.azurecr.io"
    username = var.ARM_CLIENT_ID
    password = var.ARM_CLIENT_SECRET
  }
}
