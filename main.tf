
module "ansible-inventory" {
    source              = "./terraform/modules/ansible-inventory"
    remote_user         = var.remote_user
    private_key_path    = var.private_key_path
    env_file            = var.env_file
    secret_key          = var.secret_key
    utils_secret        = var.utils_secret
    hosts               = var.hosts
    redis               = var.redis
    outline             = var.outline
    postgres            = var.postgres
    postgres_test       = var.postgres_test
    minio               = var.minio
    https_portal        = var.https_portal
}
