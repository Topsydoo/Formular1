# configure auto scaling

resource "aws_launch_configuration" "project7_as" {
  name_prefix   = "project7_as"
  image_id      = "ami-066333d9c572b0680"
  instance_type = "t2.micro"
}

