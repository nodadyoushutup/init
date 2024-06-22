# Use a base image with bash installed
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the hello.sh script into the container
COPY script/hello.sh /app/hello.sh

# Ensure the script is executable
RUN chmod +x /app/hello.sh

# Define the entry point of the container
ENTRYPOINT ["/app/hello.sh"]
