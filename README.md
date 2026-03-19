# Docker Mastery Assignment

## Image URLs
- **DockerHub:** https://hub.docker.com/r/zionccit/flask-app
- **GHCR:** ghcr.io/zionccit-dotcom/flask-app
- **ECR:** 520819256692.dkr.ecr.us-east-1.amazonaws.com/flask-app

## Run Locally
```bash
docker compose up --build -d
```

This will start three services:
- **web** — Flask application on port 5000
- **postgres** — PostgreSQL 16 database
- **redis** — Redis 7 cache (used for visit counter)

Once running, verify the app:
```bash
curl http://localhost:5000
```

To stop and remove all containers and volumes:
```bash
docker compose down -v
```

## Challenges Encountered

### 1. `version` attribute warning in docker-compose.yml
**Issue:** Docker Compose printed a warning on every command: `the attribute 'version' is obsolete, it will be ignored`.  
**Resolution:** Removed the top-level `version:` key from `docker-compose.yml`, as it is no longer required in modern Compose versions.

### 2. Tagging and pushing to multiple registries
**Issue:** Managing the same image across three different registries (DockerHub, GHCR, ECR) required separate authentication steps and correct tag formatting for each registry.  
**Resolution:** Used `docker tag` to create registry-specific tags from the base image, then authenticated to each registry separately before pushing:
- DockerHub: `docker login`
- GHCR: `docker login ghcr.io` with a GitHub personal access token
- ECR: `aws ecr get-login-password | docker login --username AWS --password-stdin <ecr-uri>`

### 3. Container startup ordering (web waiting on postgres)
**Issue:** The Flask web container started before PostgreSQL was fully ready, causing connection errors on initial startup.  
**Resolution:** Added a `healthcheck` to the postgres service and used `depends_on` with `condition: service_healthy` in the web service definition to ensure proper startup ordering.

### 4. Accidental command typo in terminal
**Issue:** Accidentally merged two commands into one (`docker compose logsdocker compose down`), which the shell could not parse.  
**Resolution:** Recognized the error from the shell output and ran the commands separately.





 
