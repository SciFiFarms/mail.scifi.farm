
# Add a record to the domain
resource "digitalocean_record" "mx" {
  domain = "${var.domain}"
  type   = "MX"
  name   = "mail"
  priority = "10"
  ttl    = "120"
  value  = "@"
}

## Backup email server
#resource "digitalocean_record" "mx_backup" {
#  domain = "${var.domain}"
#  type   = "MX"
#  name   = "mail"
#  priority = "20"
#  ttl    = "120"
#  value  = "${var.mx_backup}."
#}

resource "digitalocean_record" "mail" {
  domain = "${var.domain}"
  type   = "A"
  name   = "mail"
  ttl    = "120"
  value  = "${var.ipv4_address}"
}

resource "digitalocean_record" "www" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "www.mail"
  ttl    = "120"
  value  = "mail."
}

resource "digitalocean_record" "autodiscover" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "autodiscover"
  ttl    = "120"
  value  = "mail."
}

resource "digitalocean_record" "autoconfig" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "autoconfig"
  ttl    = "120"
  value  = "mail."
}

resource "digitalocean_record" "dmarc" {
  domain = "${var.domain}"
  type   = "TXT"
  name   = "_dmarc"
  ttl    = "120"
  value  = "v=DMARC1; p=reject; rua=mailto:mailauth-reports@${var.domain}"
}

resource "digitalocean_record" "spf" {
  domain = "${var.domain}"
  type   = "TXT"
  name   = "@"
  ttl    = "120"
  value  = "v=spf1 include:mxlogin.com -all"
}

# Add a record to the domain
# I don't think this is nessasary: https://mxroute.helpscoutdocs.com/article/23-how-do-i-use-dkim
#resource "digitalocean_record" "dkim" {
#  domain = "${var.domain}"
#  type   = "CNAME"
#  name   = "default._domainkey"
#  //priority = "10"
#  ttl    = "120"
#  value  = "${mx_backup}"
#}
