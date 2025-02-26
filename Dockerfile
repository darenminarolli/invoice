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

# Expose the port Flask/Uvicorn will run on
EXPOSE 8000

# Run the application using the correct port
CMD exec uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}
