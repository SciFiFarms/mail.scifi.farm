# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
variable "domain" { }

# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
variable "timezone" { }

# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
variable "hcloud_token" { }

# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
#variable "mx_backup" { }

# Set the variable value in *.tfvars file
# or using -var="digitalocean_token=..." CLI option
variable "digitalocean_token" { }


variable "ssh_key_public" {
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_key_private" {
  default     = "~/.ssh/id_rsa"
}


