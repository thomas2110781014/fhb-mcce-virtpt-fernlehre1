# VIRT-PT Fernlehre 1 // Infrastructure-as-Code / AWS

Deploy the open-source Git Server [Gitea](https://gitea.io)
with a Postgres Database and Caddy HTTPS Proxy on AWS.
Each of the three services runs on its own EC2 instance.

The provisioning is done by passing a shell script via
cloud-init to the instances during boot.

## Requirements

- Install [Terraform](https://www.terraform.io/downloads)
- Supply your AWS credentials (e.g. in the file `~/.aws/credentials`)

## Usage

Provide a database password in `terraform.tfvars`.

First, initialize terraform:

    terraform init

Plan the configuration(check):

    terraform plan

And apply:

    terraform apply
