#Creating Launch Template and Auto-Scaling Group for Webserver Tier
  resource "aws_launch_template" "nov-template1" {
  name_prefix   = "nov-template"
  image_id      = var.ami_name
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = filebase64("${"install_apache.sh"}")
  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_confi_security_group.id]
  }
  tags = {
    Name = var.lauch_template1
  }
}

resource "aws_autoscaling_group" "asg-webtier" {
  name               = var.auto_scaling_group1
  desired_capacity   = 4
  max_size           = 6
  min_size           = 4
  health_check_grace_period = 30
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  launch_template {
    id      = aws_launch_template.nov-template1.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  
    #instructs Terraform to create the new version before destroying the original to avoid any service interruptions.
  }


}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_nov1" {
  autoscaling_group_name = aws_autoscaling_group.asg-webtier.id
  lb_target_group_arn    = aws_lb_target_group.alb-target-group.arn
}


#Creating Launch Template and Auto-Scaling Group for Application Tier
resource "aws_launch_template" "template-apptier" {
  name_prefix   = "nov-template-apptier"
  image_id      = var.ami_name
  instance_type = var.instance_type
  key_name = var.key_name
  #user_data = filebase64("${"install_apache.sh"}")
  
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.asg_confi_security_group2.id]
  }
  tags = {
    Name = var.lauch_template2
  }
}

resource "aws_autoscaling_group" "asg-apptier" {
  name               = var.auto_scaling_group2
  desired_capacity   = 4
  max_size           = 6
  min_size           = 4
  health_check_grace_period = 30
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  launch_template {
    id      = aws_launch_template.template-apptier.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
    
    #instructs Terraform to create the new version before destroying the original to avoid any service interruptions.
  }


}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_nov2" {
  autoscaling_group_name = aws_autoscaling_group.asg-apptier.id
  lb_target_group_arn    = aws_lb_target_group.alb-target-group2.arn
}
