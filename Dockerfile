# Use an official Docker image that includes Docker and Docker Compose
FROM docker:latest

# Install Docker Compose inside the container
RUN apk add --no-cache docker-compose

# Copy the test.yaml file into the container
COPY test.yaml /app/test.yaml

# Set the working directory
WORKDIR /app

# Run the Docker Compose file when the container starts
CMD ["docker-compose", "-f", "test.yaml", "up"]
