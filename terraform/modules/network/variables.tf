variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = "string"
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Example: 10.10.0.0/16"
  type        = "string"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "bastion_image_id" {
  description = "The image id for bastion server."
  type        = "string"
}

variable "bastion_instance_type" {
  description = "The instance type for bastion server."
  type        = "string"
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = ""
}
