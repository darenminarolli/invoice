# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy only requirements first (for better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the default port
EXPOSE 8000

# Run a Python script to handle environment variables properly
CMD python -c "import os; import uvicorn; uvicorn.run('app:app', host='0.0.0.0', port=int(os.environ.get('PORT', 8000)))"
