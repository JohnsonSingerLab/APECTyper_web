# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy current project into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && pip install -r requirements.txt

# Set the default port for Flask
ENV PORT=5000

# Run the Flask app
CMD ["python", "-m", "app.main"]
