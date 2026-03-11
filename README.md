# Docker Flask + Redis Assignment

## Project Overview
This project demonstrates containerization using Docker, multi-container orchestration using Docker Compose, and pushing container images to multiple registries including DockerHub, GitHub Container Registry, and AWS ECR.

The application is a simple Flask API that connects to Redis to store and increment a visit counter.

---

## Architecture

User Request  
⬇  
Flask API (Docker Container)  
⬇  
Redis (Docker Container)  
⬇  
Visit Counter Stored in Redis

---

## Technologies Used

- Python
- Flask
- Redis
- Docker
- Docker Compose
- DockerHub
- GitHub Container Registry
- AWS Elastic Container Registry (ECR)

---

## Project Structure

```
docker-assignment
│
├── app.py
├── Dockerfile
├── requirements.txt
├── docker-compose.yml
└── README.md
```

---

## Step 1 – Build Docker Image

```bash
docker build -t flask-app:v1 .
```

---

## Step 2 – Run Container

```bash
docker run -p 5000:5000 flask-app:v1
```

Test API:

```bash
curl http://localhost:5000
```

Example Output:

```
{"hostname":"container_id","message":"Hello from Docker!"}
```

---

## Step 3 – Push Image to DockerHub

```bash
docker tag flask-app:v1 Zionccit/flask-app:v1
docker push Zionccit/flask-app:v1
```

---

## Step 4 – Push Image to AWS ECR

Create repository:

```bash
aws ecr create-repository --repository-name flask-app --region us-east-1
```

Login:

```bash
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS \
--password-stdin 520819256692.dkr.ecr.us-east-1.amazonaws.com
```

Tag image:

```bash
docker tag flask-app:v1 \
520819256692.dkr.ecr.us-east-1.amazonaws.com/flask-app:v1
```

Push image:

```bash
docker push \
520819256692.dkr.ecr.us-east-1.amazonaws.com/flask-app:v1
```

---

## Step 5 – Run Multi-Container Application

Start containers:

```bash
docker compose up --build
```

Test application:

```bash
curl http://localhost:5000
```

Example Output:

```
{"hostname":"ee0988dd032a","message":"Hello from Docker!"}
```

Redis will track visit counts.

---

## Screenshots

### Running Containers
(screenshot here)

### Docker Compose Logs
(screenshot here)

### Successful API Response
(screenshot here)

### DockerHub Repository
(screenshot here)

### AWS ECR Repository
(screenshot here)

---

## Author

Kwame Kadzashie