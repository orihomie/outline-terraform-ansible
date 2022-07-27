resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl", {
    hosts = var.hosts
  })
  filename = "${path.root}/hosts.cfg"
}

resource "local_file" "ansible_cfg" {
  content = templatefile("${path.module}/templates/ansible.tpl", {
    remote_user         = var.remote_user
    private_key_path    = var.private_key_path
  })
  filename = "${path.root}/ansible.cfg"
}

locals {
  database = {
    url = "postgres://${var.postgres.user}:${var.postgres.password}@postgres:${var.postgres.port}/${var.postgres.db}",
    test_url = "postgres://${var.postgres_test.user}:${var.postgres_test.password}@postgres:${var.postgres.port}/${var.postgres_test.db}"
  }

  aws = {
    access_key_id           = var.minio.root_user
    secret_access_key       = var.minio.root_password
    region                  = "us-east-1"
    s3  = {
      accelerate_url = ""
      upload = {
        bucket_url  = "https://wiki-storage.${var.domain}"
        bucket_name = "outline"
        max_size    = 26214400
      }      
      force_path_style = true
      acl           = "private"
    }
  }

  outline = merge(var.outline, {
    url = "https://wiki.${var.domain}"
  })
}

resource "local_file" "docker_env" {
  content = templatefile("${path.module}/templates/docker.env.tpl", {
    aws:          local.aws
    secret_key:   var.secret_key
    utils_secret: var.utils_secret
    env_file:     var.env_file
    outline:      local.outline
    redis:        var.redis
    postgres:     var.postgres
    minio:        var.minio
    https_portal: var.https_portal
    database:     local.database
  })
  filename = "${path.root}/docker.env"
}

resource "local_file" "docker_compose_file" {
  content = templatefile("${path.module}/templates/docker-compose.tpl", {
    env_file: var.env_file
    outline: var.outline
    postgres: var.postgres
    minio: var.minio
    https_portal: var.https_portal
  })
  filename = "${path.root}/docker-compose.yml"
}
