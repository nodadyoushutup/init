#!/bin/bash

source /script/utils.sh

namespace-check
pvc-bound
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
set-arr-config
