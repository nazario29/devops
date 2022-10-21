# Update git branch from Jenkins Job

## Description
This script is supposed to be executed inside Jenkins server and aims to remove a list of goals and/or analysis tools from Jenkins Jobs the list should be filled on `goals_list` and `analysis_tools_list` variable arrays.
After the script execution, to apply this configuration it is necessary to reload configuration from disk in Manage Jenkins menu

## Requirements
No specific requisites are needed to use this script, other than the Jenkins server itself.

## Script in detail
Script does a set of actions to grab existing configurations from each Jenkins Job, generates a backup file for each one and the replaces the configuration

## How to run it
```
How to use the script: bash remove_goals_and_analysistools.sh
```