# Outline Terraform Ansible

Automated deployment of Outline, a modern knowledge base, using Terraform and Ansible.

## Deployment 

Terraform & Ansible double to generate files and deploy outline to remote hosts.

Terraform module generate these files:
- `ansible.cfg`
- `hosts.cfg`
- `docker-compose.yml`
- `docker.env` 

Then Ansible playbook deploys this configuration to remote host(s).

‼️ Not tested properly, use at your own riks.

## Prerequisites

* Terraform
* Ansible

## How to use

1. You could update values in the `vars.tf` or `terrafrom.tfvars` file before running `terrafrom apply`.
2. Run `terrafrom apply`
3. Check if ansible hosts are available:
> ansible -i hosts.cfg all -b -m ping 
4. Check if playbook is OK:
> ansible-playbook -i hosts.cfg ansible-deploy-outline.yml -v --check
5. Run playbook:
> ansible-playbook -i hosts.cfg ansible-deploy-outline.yml 
6. ... (wait)
7. PROFIT!