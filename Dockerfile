# Use an official MongoDB image as the base image
FROM mongo:latest

# Set environment variables for MongoDB authentication
ENV MONGO_INITDB_ROOT_USERNAME=admin
ENV MONGO_INITDB_ROOT_PASSWORD=securepassword

# Expose MongoDB port
EXPOSE 27017

# Start MongoDB with authentication
CMD ["mongod", "--bind_ip_all", "--auth"]
