from flask import Flask, jsonify
import socket
import redis
import os

app = Flask(__name__)

redis_host = os.getenv("REDIS_HOST", "redis")
r = redis.Redis(host=redis_host, port=6379)

@app.route("/")
def home():
    visits = r.incr("visits")

    return jsonify({
        "message": "Hello from Docker Compose!",
        "hostname": socket.gethostname(),
        "visits": int(visits)
    })

@app.route("/health")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)