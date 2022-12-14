#!/bin/bash
set -euo pipefail

# Set variables and read functions file
SCRIPTPATH=$(readlink -f "$0")
FUNCTIONS=$(dirname "$SCRIPTPATH")
. "$FUNCTIONS/functions"

nexus_url="nexus.dev6-poc-kublr.ilendx.tech"
docker_repository="docker-private"

read -r -p "username: " username
read -r -s -p "password: " password
echo ""
read -r -p "microservice: " microservice_name
read -r -p "version: " compare_version

remove_dockerimages_by_semver