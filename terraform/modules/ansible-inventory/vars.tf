variable "remote_user" {
    description = "AWS hosts default user"
}

variable "private_key_path" {
    description = "SSH key path on a local ansible host"
}

variable "hosts" {
    description = "Map with named host list: {group: [host1, host2], ...}"
    type        = map
}

variable "env_file" {
    type        = string
}

variable "secret_key" {
    type        = string
}

variable "utils_secret" {
    type        = string
}

variable "redis" {}
variable "outline" {}
variable "postgres" {}
variable "minio" {}
variable "https_portal" {}