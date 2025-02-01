# Use an official MongoDB image as the base image
FROM mongo:latest

# Set environment variables for MongoDB
ENV MONGO_INITDB_ROOT_USERNAME=vsay 
ENV MONGO_INITDB_ROOT_PASSWORD=vsay123

# Expose MongoDB port
EXPOSE 27017

# Create a volume to persist database data
VOLUME /data/db

# Start MongoDB
CMD ["mongod", "--bind_ip_all"]

# Use an official Mongo Express image
FROM mongo-express:latest

# Set environment variables for Mongo Express
ENV ME_CONFIG_BASICAUTH_ENABLED=false \
    ME_CONFIG_MONGODB_ADMINUSERNAME=vsay \
    ME_CONFIG_MONGODB_ADMINPASSWORD=vsay123 \
    ME_CONFIG_MONGODB_URL=mongodb://vsay:vsay123@mongo:27017/

# Expose Mongo Express port
EXPOSE 8081

# Start Mongo Express
CMD ["npm", "start"]
