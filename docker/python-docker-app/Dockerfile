# Use an official Python image as the base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies first
# This leverages Docker's layer caching for faster builds if requirements don't change
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY app.py .

# Inform Docker that the container listens on the specified port at runtime
EXPOSE 5000

# Define the command to run the application when the container starts
CMD ["python", "app.py"]
