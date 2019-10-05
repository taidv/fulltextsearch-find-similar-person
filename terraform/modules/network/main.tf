# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs             = "${slice(data.aws_availability_zones.available.names, 0, 3)}"
  private_subnets = ["${cidrsubnet(var.vpc_cidr, 8, 1)}", "${cidrsubnet(var.vpc_cidr, 8, 2)}", "${cidrsubnet(var.vpc_cidr, 8, 3)}"]
  public_subnets  = ["${cidrsubnet(var.vpc_cidr, 8, 4)}", "${cidrsubnet(var.vpc_cidr, 8, 5)}", "${cidrsubnet(var.vpc_cidr, 8, 6)}"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = "${var.tags}"
}

module "bastion" {
  source  = "../bastion"

  key_name            = "${var.key_name}"
  image_id            = "${var.bastion_image_id}"
  instance_type       = "${var.bastion_instance_type}"
  security_groups     = ["${aws_security_group.bastion.id}"]
  vpc_zone_identifier = "${module.vpc.public_subnets}"

  user_data = <<EOL
              #!/bin/bash -x
              echo Hello
              EOL

  # depends_on  = ["module.vpc.vpc_id"]
  tags        = ["${var.tags}"]
}

resource "aws_security_group" "bastion" {
  name_prefix = "Bastion SG"
  description = "Security group for bastion server."
  vpc_id      = "${module.vpc.vpc_id}"

  depends_on  = ["module.vpc.vpc_id"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

locals {
  tags = [
    {
      key                 = "Name"
      value               = "Bastion"
      propagate_at_launch = true
    },
  ]
}
