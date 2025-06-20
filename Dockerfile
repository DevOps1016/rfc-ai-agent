# Use official Python image as base
FROM python:3.11-slim

# Install system dependencies (Tesseract, poppler for PDF, and build tools)
RUN apt-get update && \
    apt-get install -y \
        tesseract-ocr \
        libtesseract-dev \
        poppler-utils \
        build-essential \
        git \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8501

ENV PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_NO_CACHE_DIR=on \
    STREAMLIT_SERVER_HEADLESS=true \
    STREAMLIT_SERVER_ENABLECORS=false \
    STREAMLIT_SERVER_ENABLEWEBRTC=false

CMD ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]