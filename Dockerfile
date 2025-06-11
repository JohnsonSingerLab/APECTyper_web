# Use official lightweight Python image
FROM python:3.10-slim


# Install build dependencies
RUN apt-get update && apt-get install -y gcc python3-dev


#Set working directory inside container
WORKDIR /app

# Copy current project into the container
COPY . .

# Install dependencies
# RUN pip install --no-cache-dir --upgrade pip && pip install -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Set the default port for Flask
ENV PORT=5000

# Run the Flask app
# CMD ["python", "-m", "app.main"]

# Run the app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app.main:app"]