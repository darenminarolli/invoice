# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Prevent Python from writing pyc files and enable output buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (if your app needs any compilation/build tools)
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements.txt first to leverage Docker cache for dependencies
COPY requirements.txt /app/

# Create a virtual environment and install Python dependencies
# (Alternatively, you can install globally; here, we just use pip directly)
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of your application code into the container
COPY . /app/

# Expose the port that your Flask app runs on (adjust if needed)
EXPOSE 5000

# Command to run your Flask app.
# Ensure your Flask app is set to run on host 0.0.0.0 so it is accessible
CMD ["python", "app.py"]
