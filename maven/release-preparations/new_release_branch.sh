#!/bin/bash
set -euo pipefail
# How to use the script: bash branch_preparation.sh -t major -r /path/to/repo -n sample-java-app

SCRIPTPATH=$(readlink -f "$0")
FUNCTIONS=$(dirname "$SCRIPTPATH")
. "$FUNCTIONS/functions"

# Get the options
while getopts t:r: option; do
  case "${option}" in
    t | --release_type) export release_type=${OPTARG} ;;
    r | --repo_path) export repo_path=${OPTARG} ;;
    \?) # Invalid option
      echo "Invalid option"
      exit
      ;;
  esac
done

# Check if mvn is installed
mvn --version>/dev/null 2>&1 || { echo >&2 "I require mvn but it's not installed.  Installing..."; sudo apt-get install maven; }

# Check if mvn is installed
java --version>/dev/null 2>&1 || { echo >&2 "I require java but it's not installed.  Installing..."; sudo apt install default-jre; }

# Check if JAVa_HOME env var is set
javahome="$JAVA_HOME"
if [ -z "$javahome" ]
then
  echo "SET JAVA_HOME ENV VAR FIRST FIRST!"
  exit 1
fi

#Create new git branch based on pom.xml versions
git_create_branch

#Set versions on Manta project using maven plugin
set_versions

#Commit changes on original branch
commit_changes

#Deploy artifacts
deploy_artifacts