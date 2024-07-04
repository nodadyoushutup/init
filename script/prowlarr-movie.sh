#!/bin/bash

if [ ! -f /app/config.xml ]; then
    echo "/app/config.xml does not exist. Copying from /script/prowlarr/config.xml."
    cp /config/prowlarr/movie-config.xml /app/config.xml
else
    echo "/app/config.xml already exists."
fi