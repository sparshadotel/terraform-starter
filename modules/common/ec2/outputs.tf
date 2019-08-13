
output "public_dns" {
  value = aws_instance.ec2.public_dns
}

output "public_ip" {
//  value = aws_instance.ec2.public_ip
  value = aws_eip.elastic_ip.public_ip
}

output "ec2_arn" {
  value = aws_instance.ec2.arn
}

output "private_key_pem" {
  value = tls_private_key.ec2.private_key_pem
}

