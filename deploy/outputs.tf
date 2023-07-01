# Salidas de ciertas variables o atributos de uno de los recursos

output "db_host" {
  value = aws_db_instance.main.address
}

output "bastion_host" {
  value = aws_instance.bastion.public_dns
}
