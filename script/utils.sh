#!/bin/bash
# script/utils.sh

pvc-bound(){
    local namespace="${1:-$NAMESPACE}"

    if [ -z "$namespace" ]; then
        echo "Error: Namespace must be provided either as an argument or as an environment variable."
        return 1
    fi

    echo "Waiting for PVC to be bound in ${namespace} namespace..."
    until [ "$(kubectl get pvc ${namespace}-pvc -n ${namespace} -o jsonpath='{.status.phase}')" = "Bound" ]; do
        echo "PVC not bound yet. Waiting..."
        sleep 2
    done
    echo "PVC is bound."
}

namespace-check(){
  # Check if the NAMESPACE variable is set
  if [ -z "$NAMESPACE" ]; then
    echo "NAMESPACE environment variable is not set."
    exit 1
  fi
}

set-config(){
  CONFIG_SOURCE=${1:-$CONFIG_SOURCE}
  CONFIG_DESTINATION=${2:-$CONFIG_DESTINATION}

  # Get the directory of the destination file
  DEST_DIR=$(dirname "$CONFIG_DESTINATION")

  # Create the destination directory if it does not exist
  if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory $DEST_DIR."
    mkdir -p "$DEST_DIR"
  fi

  if [ ! -f "$CONFIG_DESTINATION" ]; then
    echo "$CONFIG_DESTINATION does not exist. Copying from $CONFIG_SOURCE."
    cp "$CONFIG_SOURCE" "$CONFIG_DESTINATION"
  else
    echo "$CONFIG_DESTINATION already exists."
  fi
}

set-envs(){
  case "$NAMESPACE" in
    prowlarr-movie)
      CONFIG_SOURCE="/config/prowlarr/movie-config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    prowlarr-television)
      CONFIG_SOURCE="/config/prowlarr/television-config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    prowlarr-music)
      CONFIG_SOURCE="/config/prowlarr/music-config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    prowlarr-book)
      CONFIG_SOURCE="/config/prowlarr/book-config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    prowlarr-cross-seed)
      CONFIG_SOURCE="/config/prowlarr/cross-seed-config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    radarr)
      CONFIG_SOURCE="/config/radarr/config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    sonarr)
      CONFIG_SOURCE="/config/sonarr/config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    lidarr)
      CONFIG_SOURCE="/config/lidarr/config.xml"
      CONFIG_DESTINATION="/app/config/config.xml"
      ;;
    *)
      echo "Unknown NAMESPACE: $NAMESPACE"
      exit 1
      ;;
  esac
}