from flask import Flask, jsonify
import socket
import redis
import os
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

def get_redis():
    return redis.Redis(host=os.getenv("REDIS_HOST", "redis"), port=6379, decode_responses=True)

@app.route("/")
def home():
    r = get_redis()
    visits = r.incr("visits")
    return jsonify({
        "message": "Hello from Docker Production!",
        "hostname": socket.gethostname(),
        "visits": int(visits)
    })

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
