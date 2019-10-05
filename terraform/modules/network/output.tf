output "vpc_id" {
  description = "The vpc id"
  value       = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = "${module.vpc.public_subnets}"
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = "${module.vpc.private_subnets}"
}

output "bastion_public_ip" {
  description = "The public ip of bastion server."
  value       = "${module.bastion.public_ip}"
}