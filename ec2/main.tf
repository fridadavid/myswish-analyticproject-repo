module "ec2" {
  source                 = "../modules/ec2"
  key_name               = var.key_name
  instance_tenancy       = var.instance_tenancy
  ami_id                 = var.ami_id
  az1a                   = var.az1a
  az1b                   = var.az1b
  instance_type          = var.instance_type
  instance_name_bastion1 = var.instance_name_bastion1
  instance_name_bastion2 = var.instance_name_bastion2
  vpc_tag_environment    = var.vpc_tag_environment


}