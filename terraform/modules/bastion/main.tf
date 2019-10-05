
resource "aws_launch_configuration" "bastion" {
  name_prefix = "bastion-"

  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  enable_monitoring           = false
  security_groups             = "${var.security_groups}"

  user_data = "${var.user_data}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion" {
  name = "${aws_launch_configuration.bastion.name}-asg"

  min_size             = 0
  desired_capacity     = 1
  max_size             = 1
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.bastion.name}"
  vpc_zone_identifier  = "${var.vpc_zone_identifier}"

  tags = [
    {
      key                 = "Name"
      value               = "Bastion"
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_instance" "created" {
  instance_tags = { Name = "Bastion" }

  depends_on = ["aws_autoscaling_group.bastion"]
}