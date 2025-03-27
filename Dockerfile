# Use an official lightweight base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy files from your repo into the container
COPY . .

# Default command (for now, just keep it simple)
CMD ["echo", "Docker is working!"]
