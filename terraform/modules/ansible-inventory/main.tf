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

resource "local_file" "docker_env" {
  content = templatefile("${path.module}/templates/docker.env.tpl", {
    env_file: var.env_file
    outline: var.outline
    postgres: var.postgres
    minio: var.minio
    https_portal: var.https_portal
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
