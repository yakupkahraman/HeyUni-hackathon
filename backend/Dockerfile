# Use an official Python runtime as a base image
FROM python:3.12

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Expose the port Cloud Run will listen on
ENV PORT 8080

# Start the app
CMD ["uvicorn", "chatgpt:app", "--host", "0.0.0.0", "--port", "8080"]

