# Creating  Application Load Balancer (ALB) & Target Group for Webserver Tier
resource "aws_lb" "webserver_alb" {
  internal = "false"
  name = "webserver-alb"
  load_balancer_type = "application"
  subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  security_groups = [aws_security_group.alb_security_group.id]
  enable_deletion_protection = "false"
  
tags = { #ALB Tags
  }
}

#Creating Load Balancer Listener
resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.webserver_alb.arn
      port               = 80
      protocol           = "HTTP"

      default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

  #Target Groups
  resource "aws_lb_target_group" "alb-target-group" {
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc-project.id
  target_type      = "instance"
  protocol_version = "HTTP1"

health_check {
        enabled             = true
        interval            = 30
        path                = "/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }      
 tags = {  # Target Group Tags
      }
    }     


# Creating  Application Load Balancer (ALB) & Target Group for Application Tier
resource "aws_lb" "application_alb" {
  internal = "true"
  name = "application-alb"
  load_balancer_type = "application"
  subnets = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  security_groups = [ aws_security_group.alb_security_group2.id]
  enable_deletion_protection = "false"

tags = { #ALB Tags
  }
}

#Creating Load Balancer Listener
resource "aws_lb_listener" "listener_http2" {
  load_balancer_arn = aws_lb.application_alb.arn
      port               = 80
      protocol           = "HTTP"

      default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group2.arn
  }
}

  #Target Groups
  resource "aws_lb_target_group" "alb-target-group2" {
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc-project.id
  target_type      = "instance"
  protocol_version = "HTTP1"

health_check {
        enabled             = true
        interval            = 30
        path                = "/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }      
 tags = {  # Target Group Tags
      }
    } 
     

  
