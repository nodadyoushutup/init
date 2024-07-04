#!/bin/bash

# Check if the NAMESPACE variable is set
if [ -z "$NAMESPACE" ]; then
    echo "NAMESPACE environment variable is not set."
    exit 1
fi

# Define the configuration file based on the NAMESPACE
case "$NAMESPACE" in
    prowlarr-movie)
        CONFIG_FILE="/config/prowlarr/movie-config.xml"
        ;;
    prowlarr-television)
        CONFIG_FILE="/config/prowlarr/television-config.xml"
        ;;
    prowlarr-music)
        CONFIG_FILE="/config/prowlarr/music-config.xml"
        ;;
    prowlarr-book)
        CONFIG_FILE="/config/prowlarr/book-config.xml"
        ;;
    prowlarr-cross-seed)
        CONFIG_FILE="/config/prowlarr/cross-seed-config.xml"
        ;;
    *)
        echo "Unknown NAMESPACE: $NAMESPACE"
        exit 1
        ;;
esac

# Check if the config.xml file exists
if [ ! -f /app/config.xml ]; then
    echo "/app/config.xml does not exist. Copying from $CONFIG_FILE."
    cp "$CONFIG_FILE" /app/config.xml
else
    echo "/app/config.xml already exists."
fi
