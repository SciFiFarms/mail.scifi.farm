## About 
This repo is how I'm provisioning and maintaining my spencerslab.com email server. I use Mailcow to do all the email handling. Included are the Terraform configs and Ansible playbooks necessary to stand up a Mailcow instance in the cloud. 

It utilizes Hetzner for its cloud provider because it's about 1/4 the price of a comparable AWS instance. They manage the low cost by not doing anything outside of VPS, IPs, and volumes. That's why I've had to rely upon DigitalOcean to provide DNS management (they do it for free). 

### Cost breakdown
DNS: $10/yr
VPS: €5/month ~= $5.6/month
Total: $6.5/month or $78/year. 

### Software requirements
Git 
[Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

### Needed Accounts
1. [Hetzner Cloud account](https://accounts.hetzner.com/login) and [API Token](https://docs.hetzner.cloud/#overview-getting-started)
2. [DigitalOcean account](https://cloud.digitalocean.com/login) and [API Token](https://cloud.digitalocean.com/account/api/tokens)
3. Domain to receive email at. I've been fairly happy using [namecheap](https://www.namecheap.com/).
    - You'll need to [point the ns records](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars#registrar-namecheap) to DigitalOcean's name servers: ```ns1.digitalocean.com ns2.digitalocean.com ns3.digitalocean.com```
4. [Timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) you're in. Defaults to America/Denver.

## Deploying Mailcow
Once you've gathered the above, clone the repo and create your tarraform.tfvars file.
```
git clone https://github.com/SciFiFarms/mail.spencerslab.com.git mail
cd mail
cp tarraform.tfvars.template tarraform.tfvars
```

Once that's done, you'll need to edit tarraform.tfvars and fill in the appropriate values. 

Finally, run the following and you should have a running Mailcow instance in under 10 minutes. 
```
terraform init
terraform apply
```
