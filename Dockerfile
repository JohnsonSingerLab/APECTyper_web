# Use official lightweight Python image
FROM python:3.10-slim

<<<<<<< HEAD
# Set working directory inside container
=======

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    git \
 && rm -rf /var/lib/apt/lists/*


#Set working directory inside container
>>>>>>> 7659e30 (Clean up Dockerfile)
WORKDIR /app

# Copy current project into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && pip install -r requirements.txt

# Expose Flask port
EXPOSE 5000
ENV PORT=5000

# Run the app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app.main:app"]
