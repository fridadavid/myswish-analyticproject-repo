module  "record" {
  source = "./dnsr"

  zone_name = var.zone-name
  #  zone_id = local.zone_id

  records = [
    {
      name    = "test-alias-record"
      type    = "A"
      alias   = {
        name    = var.elb-name
        zone_id = "ZLY8HYME6SFAD"
      }
    }
  ]

    }