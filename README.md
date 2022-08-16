# Outline Terraform Ansible

Automated deployment of Outline, a modern knowledge base, using Terraform and Ansible.<br>
There's [another](https://github.com/rjsgn/outline-terraform-ansible) repo called such and I've created this one because it didn't helped me to achieve my purposes.

## Deployment 

Terraform & Ansible double to generate files and deploy outline to remote hosts.

Terraform module generate these files:
- `ansible.cfg`
- `hosts.cfg`
- `docker-compose.yml`
- `docker.env` 

Then Ansible playbook deploys this configuration to remote host(s).

‼️ Not tested properly, use at your own risks.

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


## AWS Setup

IAM Policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor",
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectAcl",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:aws:s3:::MAKE_SURE_TO_PUT_PROPER_BUCKET_NAME_HERE/*"
        }
    ]
}
```

Create the policy above, create the user, attach that policy to that user.<br>

CORS
```
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "PUT",
            "POST",
            "DELETE",
            "GET"
        ],
        "AllowedOrigins": [
            "https://yourdomain.com",
        ],
        "ExposeHeaders": [
            "x-amz-server-side-encryption",
            "x-amz-request-id",
            "x-amz-id-2"
        ]
    },
    {
        "AllowedHeaders": [],
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": [
            "x-amz-server-side-encryption",
            "x-amz-request-id",
            "x-amz-id-2"
        ]
    }
]
```
