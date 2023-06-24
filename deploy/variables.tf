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

