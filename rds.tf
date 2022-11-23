#Creating RDS Instance Subnet Group
resource "aws_db_subnet_group" "nov_rds" {
  name       = "nov_rds"
  subnet_ids = [aws_subnet.private_subnet3.id, aws_subnet.private_subnet4.id]

  tags = {
    Name = var.rds_subnet_name
  }
}

#Creating RDS Instance
resource "aws_db_instance" "rds_instance" {
  db_subnet_group_name   = aws_db_subnet_group.nov_rds.id
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.rds_engine
  engine_version       = var.rds_engineversion
  instance_class       = var.rds_instanceclass
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.parameter_name
  skip_final_snapshot  = true
  vpc_security_group_ids    = [aws_security_group.db_security_group.id]
  multi_az             = true

tags = {
    Name = var.rds_name
  }
}