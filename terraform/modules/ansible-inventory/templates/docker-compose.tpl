version: "3"
services:

  outline:
    image: ${outline.image}                             
    env_file: ${env_file}
    depends_on:
      - postgres
      - redis
      - storage

  redis:
    image: redis
    env_file: ${env_file}
    volumes:
      - ./redis.conf:/redis.conf
    command: ["redis-server", "/redis.conf"]
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 30s
      retries: 3

  postgres:
    image: ${postgres.image}
    env_file: ${env_file}
    volumes:
      - database-data:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: ${postgres.user}
      POSTGRES_PASSWORD: ${postgres.password}
      POSTGRES_DB: ${postgres.db}
    healthcheck:
      test: ["CMD", "postgres_isready -U ${postgres.user}"]
      interval: 30s
      timeout: 20s
      retries: 3

  storage:
    image: ${minio.image}
    env_file: ${env_file}
    entrypoint: sh
    command: -c 'minio server /data --console-address ":${minio.console_address}"' 
    deploy:
      restart_policy:
        condition: on-failure
    environment:
      MINIO_ROOT_USER:     ${minio.root_user}     
      MINIO_ROOT_PASSWORD: ${minio.root_password} 
    volumes:
      - storage-data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3

  https-portal:
    image: ${https_portal.image}
    env_file: ${env_file}
    ports:
      - '80:80'
      - '443:443'
    links:
      - outline
      - storage
    restart: always
    volumes:
      - https-portal-data:/var/lib/https-portal
    environment:
      DOMAINS: ${https_portal.domains} 
      STAGE: ${https_portal.stage}
      WEBSOCKET: true
      CLIENT_MAX_BODY_SIZE: 100M
    healthcheck:
      test: ["CMD", "service", "nginx", "status"]
      interval: 30s
      timeout: 20s
      retries: 3

volumes:
  https-portal-data:
  storage-data:
  database-data:
