
#Creating Security Group for Webserver Load Balancer
resource "aws_security_group" "alb_security_group" {
  description = "Application load balancer security group"
  vpc_id      = aws_vpc.vpc-project.id

#Creating Inbound Rules
  ingress {
    description      = "Allow HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sec_group1
  }
}


#Creating Security Group for Webserver ASG Launch Template
resource "aws_security_group" "asg_confi_security_group" {
  description = "ASG Launch Template security group"
  vpc_id      = aws_vpc.vpc-project.id

#Creating Inbound Rules
  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sec_group2
  }
}

#Creating Security Group for Application ASG Launch Template2
resource "aws_security_group" "asg_confi_security_group2" {
  description = "ASG Launch Template security group2"
  vpc_id      = aws_vpc.vpc-project.id

#Creating Inbound Rules
ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group2.id]
}


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sec_group3
  }
}

#Creating Security Group for Application Load Balancer
resource "aws_security_group" "alb_security_group2" {
  description = "Application load balancer security group"
  vpc_id      = aws_vpc.vpc-project.id

#Creating Inbound Rules
  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.asg_confi_security_group.id]
  }

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sec_group4
  }
}


#Creating Security Group for Database Tier
resource "aws_security_group" "db_security_group" {
  description = "Database Tier security group"
  vpc_id      = aws_vpc.vpc-project.id

#Creating Inbound Rules
  ingress {
    description      = "Allow HTTP"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.asg_confi_security_group2.id]
  }

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sec_group5
  }
}
