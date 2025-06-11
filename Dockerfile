# Use official lightweight Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy current project into the container
COPY . .

# Install dependencies
# RUN pip install --no-cache-dir --upgrade pip && pip install -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Expose Flask port
EXPOSE 5000
ENV PORT=5000

# Run the app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app.main:app"]