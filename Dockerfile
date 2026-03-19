FROM python:3.11-slim-bookworm AS builder
WORKDIR /app
COPY requirements.txt .
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim-bookworm AS runtime
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
COPY app.py .
RUN adduser --disabled-password --gecos "" appuser && \
    chown -R appuser /app
USER appuser
ENV PATH=/opt/venv/bin:$PATH
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
