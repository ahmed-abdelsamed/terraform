terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.83.0"
    }
  }
}

provider "azurerm" {
  //  subscription_id = "8566b0af-f5ad-4983-ba3e-1d1955fade62"
  // tenant_id = "b566de8f-4b6f-4ceb-9487-43d706b81d61"
  // client_id = "3a6e4b02-1554-4350-8285-b310062885b1"
  #client_secret = var.client_secret
  // client_secret = "1ve8Q~J2IHI9wGifaiXSg8tUGTCXkV7jVPtRKchA"   # name Prod_RS-Sec
  features {}
}
