#!/bin/bash



# source /script/utils.sh

if [ ! -f /app/config.xml ]; then
    echo "/app/config.xml does not exist. Copying from /script/radarr/config.xml."
    cp /config/radarr/config.xml /app/config.xml
else
    echo "/app/config.xml already exists."
fi