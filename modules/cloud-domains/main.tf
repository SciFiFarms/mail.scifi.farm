resource "digitalocean_record" "root" {
  domain = "${var.domain}"
  type   = "A"
  name   = "@"
  ttl    = "120"
  value  = "${var.ipv4_address}"
}

resource "digitalocean_record" "cloud" {
  domain = "${var.domain}"
  type   = "A"
  name   = "cloud"
  ttl    = "120"
  value  = "${var.ipv4_address}"
}

resource "digitalocean_record" "aliases" {
  count   = "${length(var.aliases)}"  
  domain = "${var.domain}"
  type   = "A"
  name   = "${element(var.aliases, count.index)}"
  ttl    = "120"
  value  = "${var.ipv4_address}"
}
