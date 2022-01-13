# Configure application load balancer 

resource "aws_lb" "project7_lb" {
  name               = "project7-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project7_sg.id]
  subnets            = [aws_subnet.project7_pub_sub1.id, aws_subnet.project7_pub_sub2.id]

  enable_deletion_protection = false

  

  tags = {

  }
}

# target group

resource "aws_lb_target_group" "project7_tg" {
  name     = "project7-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project7_vpc.id
}

