#!/bin/bash
set -euo pipefail
# Function to update target git branch of a Jenkins Job, the list should be passed in the jenkins_jobs array which is in this file

## Set variables
# your jenkins url
export jenkins_url=yourjenkinsurl.com
# jenkins job list
export jenkins_jobs=("Job1"
    "Job2"
)

SCRIPTPATH=$(readlink -f "$0")
FUNCTIONS=$(dirname "$SCRIPTPATH")
. "$FUNCTIONS/functions"

# Get the options
while getopts u:p:b: option; do
  case "${option}" in
    u | --username) export username=${OPTARG} ;;
    p | --api_secret) export api_secret=${OPTARG} ;;
    b | --branch) export branch=${OPTARG} ;;
    \?) # Invalid option
      echo "Invalid option - How the script should be ran: bash update-job.sh -u username -p api_secret -b main"
      exit
      ;;
  esac
done

# Check if xmlstarlet is installed
xmlstarlet --version>/dev/null 2>&1 || { echo >&2 "I require xmlstarlet but it's not installed.  Installing..."; sudo apt-get install xmlstarlet; }

update_job