# Copy the installation script into the container
COPY install.sh /install_mongo.sh

# Give execution permissions to the script
RUN chmod +x /install.sh

# Run the installation script
RUN /install_mongo.sh

# Expose MongoDB port
EXPOSE 27017
