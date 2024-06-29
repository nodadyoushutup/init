# Use a base image with bash installed
FROM bitnami/kubectl:latest
LABEL org.opencontainers.image.source https://github.com/nodadyoushutup/init

# Set the working directory inside the container
WORKDIR /app

# Switch to root to change permissions
USER root

# Copy the entire script directory into the container
COPY script/ /script/
COPY config/ /config/
COPY bootstrap/ /bootstrap/


# Ensure the scripts are executable
RUN chmod +x /script/*.sh

# Switch back to the non-root user provided by the bitnami image (typically "1001")
# USER 1001

# Define the entry point of the container
ENTRYPOINT ["/script/health.sh"]

# Default command to run if no command is specified
CMD ["echo", "No command specified."]
