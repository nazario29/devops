# New release preparations for JAVA projects with Maven

## Description
Shell script with a set of functions which aims to do the necessary maven code changes and git branch operations preparations for a new release.

## Requirements
- Java
- Maven

## Script in detail
Script expects you to choose which release type you want to do (major or minor) and the path where your repo is located, then it will use a preparation branch as a resource to do all necessary changes and in the end expects the user to check if the preparation branch has the changes as expected.

Functions:
- `git_create_branch` 
    - Takes information from `pom.xml` that is present on the path which is identified by the user (`-r` or `--repo_path` arguments) about the current version and uses it to do all necessary preparations from a git branch prespective
- `set_versions`
    - Sets the versions on `pom.xml` files according to the release type the user defined
- `commit_changes`
    - Commits the changes to preparation branch
- `deploy_artifacts`
    - Deploys the artifacts into the Artifact Registry defined on `pom.xml` file.

## How to run it
```
bash new_release_branch.sh -t major -r /path/to/repo -n sample-java-app
```
