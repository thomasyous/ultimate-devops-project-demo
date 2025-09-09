FROM python:3.12-slim-bookworm AS base

WORKDIR /usr/src/app

# Install build tools and cleanup after installation
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    gcc \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application source
COPY . .

# Install OpenTelemetry auto-instrumentation if used
RUN opentelemetry-bootstrap -a install || true

# Expose port (optional but good for documentation)
EXPOSE 1010

# Declare runtime environment variable
ENV RECOMMENDATION_PORT=1010

# Start the service
ENTRYPOINT [ "python", "recommendation_server.py" ]