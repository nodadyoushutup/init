# Use an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to non-interactive to avoid any prompt during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && apt-get clean

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Set the working directory inside the container
WORKDIR /app

# Copy the entire script directory into the container
COPY script/ /script/
COPY config/ /config/
COPY bootstrap/ /bootstrap/

# Ensure the scripts are executable
RUN chmod +x /script/*.sh

# Define the entry point of the container
ENTRYPOINT ["/bin/bash"]

# Default command to run if no command is specified
CMD ["echo", "No command specified. Please specify a command."]
