# All the records needed by Mailcow. 

resource "digitalocean_record" "mx" {
  domain = "${var.domain}"
  type   = "MX"
  name   = "@"
  priority = "10"
  ttl    = "120"
  value  = "mail.${var.domain}."
}

# Backup email server
resource "digitalocean_record" "mx_backup" {
  domain = "${var.domain}"
  type   = "MX"
  name   = "@"
  priority = "20"
  ttl    = "120"
  value  = "${var.mx_backup}."
}

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
  value  = "mail.${var.domain}."
}

resource "digitalocean_record" "autodiscover" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "autodiscover"
  ttl    = "120"
  value  = "mail.${var.domain}."
}

resource "digitalocean_record" "autoconfig" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "autoconfig"
  ttl    = "120"
  value  = "mail.${var.domain}."
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

resource "digitalocean_record" "dkim" {
  domain = "${var.domain}"
  type   = "TXT"
  name   = "default._domainkey"
  ttl    = "120"
  value  = "${var.dkim}"
}

resource "digitalocean_record" "_imap-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_imap._tcp"
  ttl    = "120"
  port   = "143"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}

resource "digitalocean_record" "_imaps-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_imaps._tcp"
  ttl    = "120"
  port   = "993"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}

resource "digitalocean_record" "_pop3-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_pop3._tcp"
  ttl    = "120"
  port   = "110"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}

resource "digitalocean_record" "_pop3s-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_pop3s._tcp"
  ttl    = "120"
  port   = "995"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}

resource "digitalocean_record" "_submission-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_submission._tcp"
  ttl    = "120"
  port   = "587"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}
resource "digitalocean_record" "_smtps-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_smtps._tcp"
  ttl    = "120"
  port   = "465"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}
resource "digitalocean_record" "_sieve-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_sieve._tcp"
  ttl    = "120"
  port   = "4190"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}
resource "digitalocean_record" "_autodiscover-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_autodiscover._tcp"
  ttl    = "120"
  port   = "443"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}
resource "digitalocean_record" "_carddavs-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_carddavs._tcp"
  ttl    = "120"
  port   = "443"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}
resource "digitalocean_record" "_caldavs-_tcp" {
  domain = "${var.domain}"
  type   = "SRV"
  name   = "_caldavs._tcp"
  ttl    = "120"
  port   = "443"
  priority = "1"
  weight = "0"
  value  = "mail.${var.domain}"
}

resource "digitalocean_record" "_carddavs-_tcp-txt" {
  domain = "${var.domain}"
  type   = "TXT"
  name   = "_carddavs._tcp"
  ttl    = "120"
  value  = "path=/SOGo/dav/"
}

resource "digitalocean_record" "_caldavs-_tcp-txt" {
  domain = "${var.domain}"
  type   = "TXT"
  name   = "_caldavs._tcp"
  ttl    = "120"
  value  = "path=/SOGo/dav/"
}
