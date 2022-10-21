# Update git branch from Jenkins Job

## Description
Shell script to update target git branch from a Jenkins Job using Jenkins API.

## Requirements
- `xmlstarlet` to manipulate the `config.xml` jenkins files (if it is not installed the script will do it for you).
- Jenkins API Token - here's how you can generate one: https://www.jenkins.io/blog/2018/07/02/new-api-token-system/#content-top

## Script in detail
Script will interact with Jenkins API to fetch the existing `config.xml` file and after it will change the target branch that was defined by the user.
`jenkins_jobs` variable array needs to be filled with the jobs you want to target and structured like this:
```
export jenkins_jobs=("Job1"
    "Job2"
    "Job3"
)
```

Functions:
- update_job 
    1. Get current Job configuration
    1. Downgrade of xml version from `xml` so xmlstarlet can edit it
    1. Replace branch from Jenkins Job
    1. Rollback the downgrade of xml version to original
    1. Post new configuration into Jenkins

## How to run it
```
bash update-job.sh -u username -p api_secret -b main
```