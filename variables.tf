variable vpc_region {
    description = "making the region for the vpc a variable"
    default = "eu-west-2"
    type = string
    
}

variable availability_zone1 {
    description = "making the availability zone1 a variable"
    default = "eu-west-2a"
    type = string

}

variable availability_zone2 {
    description = "making the availability zone2 a variable"
    default = "eu-west-2b"
    type = string

}

variable cidr_block_vpc {
    description = "making the cidr block of the vpc a variable"
    default = "200.10.0.0/16"
    type = string

}

variable vpc_name {
    description = "making the name of vpc a variable"
    default = "project-nov"
    type = string
    
}

variable cidr_block_publicsub1{
    description = "making the cidr block for public subnet1 a variable"
    default = "200.10.0.0/17"
    type = string

}

variable name_publicsub1 {
    description = "making the name of public subnet 1 a variable"
    default = "web-publicsub1"
    type = string
    
}

variable cidr_block_publicsub2{
    description = "making the cidr block for public subnet2 a variable"
    default = "200.10.128.0/18"
    type = string

}

variable name_publicsub2 {
    description = "making the name of public subnet2 a variable"
    default = "web-publicsub2"
    type = string
    
}

variable cidr_block_privatesub1{
    description = "making the cidr block for private subnet1 a variable"
    default = "200.10.192.0/19"
    type = string

}

variable name_privatesub1 {
    description = "making the name of private subnet1 a variable"
    default = "app-privatesub1"
    type = string
    
}

variable cidr_block_privatesub2 {
    description = "making the cidr block for private subnet2 a variable"
    default = "200.10.224.0/20"
    type = string

}

variable name_privatesub2 {
    description = "making the name of private subnet2 a variable"
    default = "app-privatesub2"
    type = string
    
}

variable cidr_block_privatesub3 {
    description = "making the cidr block for private subnet3 a variable"
    default = "200.10.240.0/21"
    type = string

}

variable name_privatesub3 {
    description = "making the name of private subnet3 a variable"
    default = "db-privatesub1"
    type = string
    
}

variable cidr_block_privatesub4 {
    description = "making the cidr block for private subnet4 a variable"
    default = "200.10.248.0/21"
    type = string

}

variable name_privatesub4 {
    description = "making the name of private subnet4 a variable"
    default = "db-privatesub2"
    type = string
    
}

variable route_table_public {
    description = "making the name of public route table a variable"
    default = "webserver-public-route"
    type = string
    
}

variable route_table_private {
    description = "making the name of private route table a variable"
    default = "application-private-route"
    type = string
    
}

variable route_table_private2 {
    description = "making the name of private route table for database tier a variable"
    default = "database-private-route"
    type = string
    
}

variable internet_gateway_name {
    description = "making the name of internet gateway a variable"
    default = "nov-igw"
    type = string
    
}

variable eip_name1 {
    description = "making the name of elastic IP for availability zone 2a a variable"
    default = "Zone2a-eip"
    type = string
    
}

variable eip_name2 {
    description = "making the name of elastic IP for availability zone 2b a variable"
    default = "Zone2b-eip"
    type = string
    
}

variable nat_gw_name1 {
    description = "making the name of NAT Gateway for availability zone 2a a variable"
    default = "zone2a-nat-gw"
    type = string
    
}

variable nat_gw_name2 {
    description = "making the name of NAT Gateway for availability zone 2b a variable"
    default = "zone2b-nat-gw"
    type = string
    
}

variable sec_group1 {
    description = "making the name of security group for webserver tier load balancer a variable"
    default = "nov-sec-group-lb"
    type = string
    
}

variable sec_group2 {
    description = "making the name of security group for webserver launch template a variable"
    default = "webasg-sec-group"
    type = string

}

variable sec_group3 {
    description = "making the name of security group for application launch template a variable"
    default = "appasg-sec-group"
    type = string

}

variable sec_group4 {
    description = "making the name of security group for application tier load balancer a variable"
    default = "apptierlb-sec-group"
    type = string
    
}

variable sec_group5 {
    description = "making the name of security group for database tier a variable"
    default = "dbtier-sec-group"
    type = string
    
}

variable ami_name {
    description = "making the name of ami a variable"
    default = "ami-023665fdad063c8a9"
    type = string
    
}

variable instance_type {
    description = "making the instance type a variable"
    default = "t2.micro"
    type = string
    
}

variable key_name {
    description = "making the key name a variable"
    default = "Manna"
    type = string
    
}

variable lauch_template1 {
    description = "making the launch template1 name a variable"
    default = "webserver-tier"
    type = string
    
}

variable auto_scaling_group1 {
    description = "making the auto-scaling group1 name a variable"
    default = "webserver-asg"
    type = string
    
}

variable lauch_template2 {
    description = "making the launch template2 name a variable"
    default = "app-tier"
    type = string
    
}

variable auto_scaling_group2 {
    description = "making the auto-scaling group2 name a variable"
    default = "apptier-asg"
    type = string
    
}

variable rds_subnet_name {
    description = "making the name of rds subnet a variable"
    default = "nov_rdsubnet_group"
    type = string
    
}

variable rds_name {
    description = "making the name of rds a variable"
    default = "databasetier-rds"
    type = string
    
}

#RDS Variables
variable rds_engineversion {
    description = "making the rds engine version a variable"
    default = "5.7"
    type = string
    
}

variable rds_instanceclass {
    description = "making the rds instance class a variable"
    default = "db.t3.micro"
    type = string
    
}

variable rds_username {
    description = "making the rds username a variable"
    default = "nov"
    type = string
    
}

variable rds_password {
    description = "making the rds password a variable"
    default = "july2022"
    type = string
    
}

variable rds_engine {
    description = "making the rds engine a variable"
    default = "mysql"
    type = string
    
}

variable allocated_storage {
    description = "making the rds allocated storage a variable"
    default = "10"
    type = string
    
}

variable db_name {
    description = "making the database name a variable"
    default = "mydb"
    type = string
    
}

variable parameter_name {
    description = "making the parameter group name a variable"
    default = "default.mysql5.7"
    type = string
    
}