# 1. Base Image
FROM python:3.12-slim

# 2. Set Working Directory
WORKDIR /app

# 3. Set Environment Variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 4. Install System Dependencies (Optional)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 5. Install Python Dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy Application Code
COPY . .

# 7. Expose Application Port
EXPOSE 8000

# 8. Create and Switch to Non-Root User (Security Best Practice)
RUN useradd --create-home appuser
USER appuser

# 9. Define Container Startup Command
CMD ["python", "main.py"]
