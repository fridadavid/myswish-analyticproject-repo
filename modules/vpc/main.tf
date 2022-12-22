resource "aws_vpc" "swishvpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy  = var.instance_tenancy
  enable_dns_support = var.enable_dns_support  
  enable_dns_hostnames = var.enable_dns_hostnames    
  tags = {
    Name = var.vpc_tag_name
    Environment = var.vpc_tag_environment
  }
}

###################################################
###################### EIP ########################
###################################################

resource "aws_eip" "swish_eip_a" {
  vpc = true
}


resource "aws_eip" "swish_eip_b" {
  vpc = true
}

###################################################
################### Gateways ######################
###################################################
resource "aws_internet_gateway" "swish_igw" {
  vpc_id = aws_vpc.swishvpc.id

  tags = {
    Name = var.internet_gateway_name                 
    Environment = var.vpc_tag_environment                    
  }
}

resource "aws_nat_gateway" "swish_ngw_a" {
  allocation_id = aws_eip.swish_eip_a.id
  subnet_id = aws_subnet.swishpublic_1a.id
  tags = {
    Name = var.nat_gateway_a_name                        
    Environment = var.vpc_tag_environment
  }
}



resource "aws_nat_gateway" "swish_ngw_b" {
  allocation_id = aws_eip.swish_eip_b.id
  subnet_id = aws_subnet.swishpublic_1b.id
  tags = {
    Name = var.nat_gateway_b_name                        
    Environment = var.vpc_tag_environment
  }
}



##########################################################################
#VPC- FLOW LOGS
##########################################################################

/* resource "aws_flow_log" "myprac-vpc-flow-logs" {
  iam_role_arn    = aws_iam_role.flow-log-role.arn
  log_destination = aws_cloudwatch_log_group.mycloudwatch.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.tangovpc.id
}

resource "aws_cloudwatch_log_group" "mycloudwatch" {
  name = "mycloudwatch"
}


resource "aws_iam_role" "Tango-flow-log-role" {
  name = "Tango-flow-log-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow-logs-policy" {
  name = "flow-logs-policy"
  role = aws_iam_role.Tango-flow-log-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
} */


resource "aws_security_group" "swish-sg" {
  name        = "swish-sg"
  vpc_id      = aws_vpc.swishvpc.id

  ingress {
    from_port        = 22
    to_port          = 22
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
    Name = "swish-sg"
  }
}

###################################################
################# Route Tables ####################
###################################################
resource "aws_route_table" "swish_public" {
  vpc_id = aws_vpc.swishvpc.id
  tags = {
    Name = var.public_route_name           
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swish_igw.id
  }
}


resource "aws_route_table" "swish_private_a" {
  vpc_id = aws_vpc.swishvpc.id
  tags = {
    Name = var.private_route_a_name              
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.swish_ngw_a.id
  }
}

resource "aws_route_table" "swish_private_b" {
  vpc_id = aws_vpc.swishvpc.id
  tags = {
    Name = var.private_route_b_name        
  }
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.swish_ngw_a.id
  }
}



resource "aws_route_table_association" "swish_public_a" {
  subnet_id      = aws_subnet.swishpublic_1a.id
  route_table_id = aws_route_table.swish_public.id
}

resource "aws_route_table_association" "swish_public_b" {
  subnet_id      = aws_subnet.swishpublic_1b.id
  route_table_id = aws_route_table.swish_public.id
}




resource "aws_route_table_association" "tango_private_a" {
  subnet_id      = aws_subnet.swishprivate_1a.id
  route_table_id = aws_route_table.swish_private_a.id
}

resource "aws_route_table_association" "swish_private_b" {
  subnet_id      = aws_subnet.swishprivate_1b.id
  route_table_id = aws_route_table.swish_private_a.id
}

resource "aws_route_table_association" "swish_db_a" {
  subnet_id      = aws_subnet.swish_db_1a.id
  route_table_id = aws_route_table.swish_private_a.id
}



/* resource "aws_route_table_association" "tango_private_b" {
  subnet_id      = aws_subnet.tangoprivate_1b.id
  route_table_id = aws_route_table.tango_private_b.id
} */

resource "aws_route_table_association" "swish_db_b" {
  subnet_id      = aws_subnet.swish_db_1b.id
  route_table_id = aws_route_table.swish_private_b.id
}


###################################################
############ Subnets for us-east-1a ###############
###################################################
resource "aws_subnet" "swishpublic_1a" {
  vpc_id                  = aws_vpc.swishvpc.id
  cidr_block              = var.subnet_pub_1a_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch                        
  availability_zone       = var.subnet_1a_az
  tags = {
   Name = var.public_subnet_1a_name              
   Environment = var.vpc_tag_environment
  }
}

resource "aws_subnet" "swishprivate_1a" {
  vpc_id                 = aws_vpc.swishvpc.id
  cidr_block             = var.subnet_priv_1a_cidr_block
  availability_zone      = var.subnet_1a_az
  tags = {
     Name = var.private_subnet_1a_name               
     Environment = var.vpc_tag_environment
  }
}

resource "aws_subnet" "swish_db_1a" {
  vpc_id                 = aws_vpc.swishvpc.id
  cidr_block             = var.subnet_priv_db_1a_cidr_block
  availability_zone      = var.subnet_1a_az
  tags = {
     Name = var.private_db_subnet_1a_name           
     Environment = var.vpc_tag_environment
  }
}

###################################################
############ Subnets for us-east-1b ###############
###################################################
resource "aws_subnet" "swishpublic_1b" {
  vpc_id                  = aws_vpc.swishvpc.id
  cidr_block              = var.subnet_pub_1b_cidr_block
  availability_zone       = var.subnet_1b_az
  tags = {
    Name = var.public_subnet_1b_name                    
    Environment = var.vpc_tag_environment
  }
}

resource "aws_subnet" "swishprivate_1b" {
  vpc_id                  = aws_vpc.swishvpc.id
  cidr_block              = var.subnet_priv_1b_cidr_block
  availability_zone       = var.subnet_1b_az
  tags = {
    Name = var.private_subnet_1b_name                 
    Environment = var.vpc_tag_environment
  }
}

resource "aws_subnet" "swish_db_1b" {
  vpc_id                 = aws_vpc.swishvpc.id
  cidr_block             = var.subnet_priv_db_1b_cidr_block
  availability_zone      = var.subnet_1b_az
  tags = {
     Name = var.private_db_subnet_1b_name       
     Environment = var.vpc_tag_environment
  }
}


