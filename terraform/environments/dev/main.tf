provider "aws" {
  version = "~> 2.7"
  region  = "us-east-1"
  profile = "la"
}

module "network" {
  source = "../../modules/network"

  vpc_name              = "fsp-vpc"
  vpc_cidr              = "10.0.0.0/16"
  bastion_image_id      = "${data.aws_ami.amazon_linux.id}"
  bastion_instance_type = "t2.micro"
  key_name              = "${aws_key_pair.main_key.key_name}"
  
  tags = {
    Environment = "dev"
    Owner       = "Lucci Div"
  }
}

resource "aws_key_pair" "main_key" {
  key_name   = "main-key"
  public_key = "${data.template_file.public_key.rendered}"
}
