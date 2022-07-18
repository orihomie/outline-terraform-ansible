
remote_user         = "root"
private_key_path    = "~/.ssh/id_rsa"
env_file            = "docker.env"
secret_key          = "super_secret_key"
utils_secret        = "utils_top_secret"

hosts = {
    "outline"       = [{"hostname": "outline_host", "ip": "165.22.65.134"}]
}

redis = {
    url             = "redis://redis:6379"
}

outline = {
    image           = "outlinewiki/outline:0.64.4"
    url             = "https://yourwiki.domain"
    port            = 3000
    auth = {
        google = {
            client_id       = ""
            client_secret   = ""
            allowed_domains = ""
        }
    }
}

postgres = {
    image           = "postgres"
    user            = "outline"
    password        = "pwd"
    port            = 5432
    db              = "outline"
}

postgres_test = {
    image           = "postgres"
    user            = "outline"
    password        = "pwd"
    port            = 5432
    db              = "outline-test"
}

minio = {
    image           = "minio/minio"
    root_user       = "root_usr"
    root_password   = "root_pwd"
    console_address = 9001
}

https_portal = {
    image           = "steveltn/https-portal"
    domains         = "https://yourwiki.domain -> http://outline:3000"
    stage           = "staging" # local, staging, production
}