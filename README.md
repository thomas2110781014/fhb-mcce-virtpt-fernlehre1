# VIRT-PT Fernlehre 1 // Infrastructure-as-Code / AWS

Deploy the open-source Git Server [Gitea](https://gitea.io)
with a Postgres Database and Caddy HTTPS Proxy on AWS.
Each of the three services runs on its own EC2 instance.

The provisioning is done by passing a shell script via
[cloud-init](https://cloudinit.readthedocs.io/en/latest/)
to the instances during boot, which installs
Docker Engine and runs the container. The service of nip.io
is used to generate a domain name.

## Requirements

- Install [Terraform](https://www.terraform.io/downloads)
- Supply your AWS credentials (e.g. in the file `~/.aws/credentials`)

## Usage

Provide a database password in `terraform.tfvars`. For this demo purpose, this is already done.

First, initialize terraform:

    terraform init

Plan the configuration (check):

    terraform plan

And apply:

    terraform apply

When Terraform is done applying, you'll see the URL of Gitea.
Wait for it to finish installing and then visit the page.

## Troubleshooting

Ensure your default VPC has the internal IP range of `172.31.0.0/16` assigned.
