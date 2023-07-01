variable "prefix" {
  default = "web"
}

variable "project" {
  default = "web-votacion"
}

variable "contact" {
  default = "carlos.santaella@orbit.es"
}

variable "db_username" {
  description = "Username for the RDS Postgres instance"
  default     = "root"
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
  default     = "Admin2023"
}

variable "db_name" {
  description = "Password for the RDS postgres instance"
  default     = "prueba"
}

variable "bastion_key_name" {
  default = "web-app-api-devops-bastion"
}

variable "ecr_image_api" {
  description = "ECR Image for API"
  default     = "044447351162.dkr.ecr.eu-west-1.amazonaws.com/app-api-api:latest"
}

variable "ecr_image_proxy" { #POR DEFINIR
  description = "ECR Image for API"
  default     = "044447351162.dkr.ecr.eu-west-1.amazonaws.com/app-api-proxy:latest"
}

variable "dns_zone_name" {
  description = "Domain name"
  default     = "carlossantaella.com"
}

variable "subdomain" {
  description = "Subdomain por entorno"
  type        = map(string)
  default = {
    production = "api"
    staging    = "api.staging"
    dev        = "api.dev"
  }
}


