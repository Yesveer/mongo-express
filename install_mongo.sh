#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update system and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose

# Enable Docker to start on boot
sudo systemctl enable --now docker

# Create Docker Compose YAML file
echo "Setting up Docker Compose for MongoDB and Mongo Express..."
cat <<EOF > docker-compose.yml
version: '3'
services:
  mongo:
    image: mongo:latest
    container_name: some-mongo
    restart: always
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: vsay
      MONGO_INITDB_ROOT_PASSWORD: vsay123
    volumes:
      - mongo_data:/data/db
    command: ["--bind_ip_all"]

  mongo-express:
    image: mongo-express
    container_name: mongo-express
    restart: always
    ports:
      - "8081:8081"
    environment:
      ME_CONFIG_BASICAUTH_ENABLED: "false"
      ME_CONFIG_MONGODB_ADMINUSERNAME: vsay
      ME_CONFIG_MONGODB_ADMINPASSWORD: vsay123
      ME_CONFIG_MONGODB_URL: "mongodb://vsay:vsay123@mongo:27017/"

volumes:
  mongo_data:
EOF

# Start MongoDB and Mongo Express
echo "Starting MongoDB and Mongo Express..."
sudo docker-compose up -d

# Allow remote connections
echo "Configuring firewall to allow remote access..."
sudo ufw allow 27017/tcp
sudo ufw allow 8081/tcp

echo "MongoDB and Mongo Express are running!"
echo "Access Mongo Express at: http://your-server-ip:8081"
