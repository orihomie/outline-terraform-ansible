# Intro

Terraform & Ansible double to generate files and deploy outline to remote hosts.

Terraform module generate these files:
- `ansible.cfg`
- `hosts.cfg`
- `docker-compose.yml`
- `docker.env` 

Then Ansible playbook deploys this configuration to remote host(s).

‼️ Not tested properly, use at your own riks.