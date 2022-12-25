
data "aws_route53_zone" "myr53-zone" {
  name = var.zone-name
}



data "aws_elb" "nginx-elb" {
  name = var.elb-name
}


##### R53 Alias Record #####

resource "aws_route53_record" "my-test-record" {
  zone_id = data.aws_route53_zone.myr53-zone.zone_id
  name    = "www.${data.aws_route53_zone.myr53-zone.name}"
  type    = "A"

  alias {
    name                   = data.aws_elb.nginx-elb.dns_name
    zone_id                = data.aws_elb.nginx-elb.zone_id
    evaluate_target_health = true
  }
}