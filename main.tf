# TODO: Move state to Wasabi https://wasabi-support.zendesk.com/hc/en-us/articles/360003362071-How-I-do-use-Terraform-with-Wasabi-

## Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

# Create a new domain
resource "digitalocean_domain" "default" {
  name = "${var.domain}"
}

#  Main ssh key
resource "hcloud_ssh_key" "default" {
  name       = "main ssh key"
  public_key = "${file("${var.ssh_key_public}")}"
}

resource "hcloud_volume_attachment" "main" {
  volume_id = "${hcloud_volume.mail_data.id}"
  server_id = "${hcloud_server.mail.id}"
  automount = true
}

resource "hcloud_volume" "mail_data" {
  name     = "mail"
  location = "hel1"
  size     = 40
  #lifecycle {
  #  prevent_destroy = true
  #}
}

# Create a server
resource "hcloud_server" "mail" {
  name        = "mail.${var.domain}"
  image       = "debian-10"
  server_type = "cx21"
  location    = "hel1"
  ssh_keys    = ["${hcloud_ssh_key.default.name}"]

  provisioner "remote-exec" {
    # Install Python for Ansible
    inline = ["echo 'Ready for Ansible'"]

    connection {
      type        = "ssh"
      user        = "root"
      host = self.ipv4_address
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -e 'mailcow_hostname=mail.${var.domain} mailcow_tz=${var.timezone}' -i '${self.ipv4_address},' --private-key ${var.ssh_key_private} -T 300 mailcow.yml" 
  }
}

resource "hcloud_rdns" "mail" {
  server_id = "${hcloud_server.mail.id}"
  ip_address = "${hcloud_server.mail.ipv4_address}"
  dns_ptr = "mail.${var.domain}"
}

# TODO: Consider adding the needed DNS entries. 
module "mail-domains" {
  source = "./modules/mail-domains"
  domain = "${var.domain}"
  #mx_backup = "${var.mx_backup}"
  ipv4_address = "${hcloud_server.mail.ipv4_address}"
}


### TechnoCore server
# Create a server
resource "hcloud_server" "cloud" {
  name        = "cloud.${var.domain}"
  image       = "debian-10"
  server_type = "cx21"
  location    = "hel1"
  ssh_keys    = ["${hcloud_ssh_key.default.name}"]

  provisioner "remote-exec" {
    # Install Python for Ansible
    inline = ["echo 'Ready for Ansible'"]

    connection {
      type        = "ssh"
      user        = "root"
      host = self.ipv4_address
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.ssh_key_private} -T 300 technocore.yml" 
  }
}

resource "hcloud_rdns" "master" {
  server_id = "${hcloud_server.cloud.id}"
  ip_address = "${hcloud_server.cloud.ipv4_address}"
  dns_ptr = "cloud.${var.domain}"
}

module "cloud-domains" {
  source = "./modules/cloud-domains"
  domain = "${var.domain}"
  aliases = ["grav", "prometheus", "grafana", "traefik"]
  #mx_backup = "${var.mx_backup}"
  ipv4_address = "${hcloud_server.cloud.ipv4_address}"
}
