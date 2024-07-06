#!/bin/bash
# script/radarr.sh

source /script/utils.sh

ls -la /script
namespace-check
pvc-bound
set-arr-config
sleep 10000000