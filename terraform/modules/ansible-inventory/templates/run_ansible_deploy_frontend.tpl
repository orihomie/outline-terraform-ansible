#!/usr/bin/env bash

ansible-playbook -i hosts.cfg ansible-deploy-frontend.yml \
    -e S3_ENDPOINT=${s3_endpoint} \
    -e S3_ACCESS_KEY_ID=${s3_access_key_id} \
    -e S3_SECRET_ACCESS_KEY=${s3_secret_access_key} \
    -e S3_BUCKET_NAME=${s3_bucket_name} \
    -e S3_REGION=${s3_region} \
    -e S3_CONCURRENCY=${s3_concurrency} \
    -e S3_PATH=${s3_path} \
    -e SBANK_FRONTEND_IMAGE=${image}

