terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "mysql_innodb_log_waits_incident" {
  source    = "./modules/mysql_innodb_log_waits_incident"

  providers = {
    shoreline = shoreline
  }
}