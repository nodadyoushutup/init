#!/bin/bash
# script/radarr.sh

# Use absolute paths for sourcing
source /script/utils.sh

# Debug: List files in /script directory
ls -la /script

# Run the necessary functions
namespace-check
pvc-bound
set-arr-config

# Keep the container running for debugging purposes
sleep 10000000
