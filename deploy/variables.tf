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
  default     = "Admin2033="
}

variable "bastion_key_name" {
  default = "web-app-api-devops-bastion"
}

variable "ecr_image_api" {
  description = "ECR Image for API"
  # default     = "<APP ECR Image URL>:latest"   #POR DEFINIR
}

variable "ecr_image_proxy" { #POR DEFINIR
  description = "ECR Image for API"
  # default     = "<App ECR Image for Proxy>:latest"
}

# variable "django_secret_key" {
#  description = "Secret key for Django app"
#}
