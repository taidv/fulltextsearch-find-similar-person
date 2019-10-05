output "bastion_public_ip" {
  description = "Public ip of the bastion instance."
  value       = "${module.network.bastion_public_ip}"
}