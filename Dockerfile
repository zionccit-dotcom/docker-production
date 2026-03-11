# -------- Stage 1: Build dependencies --------
FROM python:3.11-slim AS builder

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --user -r requirements.txt


# -------- Stage 2: Runtime image --------
FROM python:3.11-slim

WORKDIR /app

# Create non-root user
RUN adduser --disabled-password --gecos "" appuser

# Copy installed packages from builder
COPY --from=builder /root/.local /home/appuser/.local

# Copy application code
COPY app.py .

# Change ownership
RUN chown -R appuser /app

USER appuser

# Ensure Python can find installed packages
ENV PATH="/home/appuser/.local/bin:$PATH"

EXPOSE 5000

CMD ["python", "app.py"]