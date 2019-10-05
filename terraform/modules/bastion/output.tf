output "public_ip" {
  description = "Public ip of the created instance."
  value       = data.aws_instance.created.public_ip
}