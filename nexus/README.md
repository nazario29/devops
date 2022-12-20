# Nexus script to delete docker images based on semantic version
## Description
This script will delete all docker images that have a lower version than the semantic version that the user passes as argument. Also will prompt the user for the necessary information:
- `username` to access nexus
- `password` to access nexus
- `microservice_name` to delete the images
- `version` to be used for compare 

The information about `nexus_url` and `docker_repository` should be filled onthe respective variables from `remove_dockerimages_by_semver.sh`

The script was adapted to be able to run even in git bash so it has some funny ways on how variables are iterated and populated :)
## Requirements
- username with at least delete access to `docker_repository` repository from Nexus `nexus_url`
- functions file together with the actual script `./remove_dockerimages_by_semver.sh`
- jq

## How to run the script: 
```
./remove_dockerimages_by_semver.sh
```