
output "public_ip4" {
  value = "${hcloud_server.mail.ipv4_address}"
}
