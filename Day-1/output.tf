output "public_ip" {
  value = aws_instance.name.public_ip
}

output "privateip" {
  value = aws_instance.name.private_ip
}