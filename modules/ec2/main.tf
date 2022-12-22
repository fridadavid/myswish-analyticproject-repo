####################################################################

# Creating  EC2 Instance

####################################################################
data "aws_vpc" "swishvpc" {
  filter {
    name = "tag:Name"
    values = ["Staging swishVPC"]
  }
  
}


data "aws_subnets" "swishpublic_1a"{
  # tags = {
  #   "Tier" = "private"
  # }
}



data "aws_subnets" "swishpublic_1b"{
  # tags = {
  #   "Tier" = "private"
  # }
}

data "aws_security_groups" "swish-sg"{
  filter {
    name = "tag:Name"
    values = ["swish-sg"]
  }

}


resource "aws_instance" "swish-bastion1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name= var.key_name
  availability_zone= var.az1a
  associate_public_ip_address= true
  subnet_id     =  sort(data.aws_subnets.swishpublic_1a.ids)[2]                                    
  vpc_security_group_ids = [sort(data.aws_security_groups.swish-sg.ids)[0]]                                           

  # root disk
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }

  tags = {
    "Name"        = "${var.instance_name_bastion1}"                
    "Environment" = "${var.vpc_tag_environment}"
  }

  timeouts {
    create = "10m"
  }

}


resource "aws_instance" "swish-bastion2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name= var.key_name
  availability_zone= var.az1b
  associate_public_ip_address= true
  subnet_id     =  sort(data.aws_subnets.swishpublic_1b.ids)[3]                                    
  vpc_security_group_ids = [sort(data.aws_security_groups.swish-sg.ids)[0]]                                           

  # root disk
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }

  tags = {
    "Name"        = "${var.instance_name_bastion2}"                
    "Environment" = "${var.vpc_tag_environment}"
  }
  timeouts {
    create = "10m"
  }
}




