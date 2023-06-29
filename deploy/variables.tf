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

# variable "django_secret_key" {
#  description = "Secret key for Django app"
#}
