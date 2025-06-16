# Use official lightweight Python image
FROM python:3.10-slim


# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    git \
 && rm -rf /var/lib/apt/lists/*


#Set working directory inside container
WORKDIR /app

# Copy current project into the container
COPY . .

# Ensure upload directory exists
RUN mkdir -p app/uploads

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install ectyper

# Expose Flask port
EXPOSE 5000
ENV PORT=5000

# Run the app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app.main:app"]