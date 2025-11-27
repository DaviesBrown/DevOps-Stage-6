FROM python:3.9-slim

# Install system deps needed for thriftpy2 build
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    cython3 \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python3", "main.py"]