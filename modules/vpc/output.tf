###################################################
######### Outputs used for other TF Code ##########
###################################################
output "id" {
  value = aws_vpc.swishvpc.id
}

output "pub_subnet_1a_id" {
  value = aws_subnet.swishpublic_1a.id
}


output "pub_subnet_1b_id" {
  value = aws_subnet.swishpublic_1b.id
}

output "priv_subnet_1a_id" {
  value = aws_subnet.swishprivate_1a.id
}

output "priv_subnet_1b_id" {
  value = aws_subnet.swishprivate_1b.id
}

output "priv_db_subnet_1a_id" {
  value = aws_subnet.swish_db_1a.id
}

output "priv_db_subnet_1b_id" {
  value = aws_subnet.swish_db_1b.id
}