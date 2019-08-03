# Output the FQDN for the record
output "fqdn" {
  value = "${digitalocean_record.mx.fqdn}"
}
