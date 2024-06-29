#!/bin/bash

# Function to find the most recent .tar file in a given directory containing a specific substring
find_most_recent_tar() {
  local directory=$1
  local namespace="${2:-$NAMESPACE}"
  local tar_files=($(ls -t "$directory"/*"$namespace"*.tar 2> /dev/null))

  if [[ ${#tar_files[@]} -gt 0 ]]; then
    echo "${tar_files[0]}"
  else
    echo ""
  fi
}

# Function to clean up a directory
cleanup_directory() {
  local directory=$1

  if [ -d "$directory" ]; then
    echo "$directory exists. Cleaning up existing files."
    rm -rf "$directory"/*
  else
    echo "$directory does not exist. Creating it."
    mkdir -p "$directory"
  fi
}

# Function to extract a .tar file to a given directory
extract_tar_to_directory() {
  local tar_file=$1
  local target_directory=$2

  echo "Extracting $tar_file into $target_directory."
  tar -xvf "$tar_file" -C "$target_directory"
}

# Main bootstrap function, now taking namespace as a parameter
bootstrap() {
  local bootstrap_dir="/bootstrap"
  local target_dir="$1"
  local namespace="${2:-$NAMESPACE}"

  if [ -z "$namespace" ]; then
    echo "Error: Namespace must be provided either as an argument or as an environment variable."
    return 1
  fi

  if [ ! -d "$bootstrap_dir" ]; then
    echo "$bootstrap_dir directory not found. Skipping bootstrapping process."
    return 1
  fi

  echo "Checking for .tar files in $bootstrap_dir containing '$namespace'."
  local most_recent_tar_file=$(find_most_recent_tar "$bootstrap_dir" "$namespace")

  if [[ -n "$most_recent_tar_file" ]]; then
    echo "Found .tar file: $most_recent_tar_file"
    cleanup_directory "$target_dir"
    extract_tar_to_directory "$most_recent_tar_file" "$target_dir"
    echo "Extraction completed."
  else
    echo "No .tar files found in $bootstrap_dir containing '$namespace'."
  fi
}

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