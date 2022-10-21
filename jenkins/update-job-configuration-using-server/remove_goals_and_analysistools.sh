#!/bin/bash

# Description: This script is supposed to be executed inside Jenkins server and aims to remove a list of goals and/or analysis tools from Jenkins Jobs
# the list should be filled on goals_list and analysis_tools_list variable arrays

#=============================================================================#
# Variables                                                                   #
#=============================================================================#

log_file="/tmp/$(basename -s .sh $0).$(date +"%Y%m%d_%H%M%S")"
location="/var/lib/jenkins/jobs"

goals_list=("checkstyle:checkstyle"
    "pmd:pmd"
    "pmd:cpd"
    "findbugs:findbugs")
analysis_tools_list=("io.jenkins.plugins.analysis.warnings.FindBugs"
    "io.jenkins.plugins.analysis.warnings.Cpd"
    "io.jenkins.plugins.analysis.warnings.Pmd"
    "io.jenkins.plugins.analysis.warnings.tasks.OpenTasks"
    "io.jenkins.plugins.analysis.warnings.Java"
    "io.jenkins.plugins.analysis.warnings.MavenConsole"
)

#=============================================================================#
# Functions                                                                   #
#=============================================================================#

# Backup config.xml
f_backup() {
    while read -r file; do
        if [ ! -f "${file}.bkp" ]; then
            cp -r "$file" "$file".bkp &
        fi
    done <$1
    wait
}

#=============================================================================#
# Main                                                                        #
#=============================================================================#

case $1 in
rollback)
    echo "Start rollback procedure"
    # Find files with .bkp and remove .bkp extension
    if [ ! -z "$(find $location -name "*.bkp" -print -quit)" ]; then
        find $location -name "*.bkp" -type f -exec sh -c 'mv -v "$1" "${1%.bkp}"' sh {} \; >>${log_file}.rollback.log
        echo "Log: ${log_file}.rollback.log"
        echo -e "\e[0;31mFor the changes to take effect, don't forget to Reload Configuration from Disk in Manage Jenkins menu.\e[m"
    else
        echo -e "\e[0;31mNo backup files were found\e[m"
    fi
    ;;
*)
    echo "Remove static code analysis"
    # Find all files with to remove
    echo "Find files with goals to remove"
    for i in ${goals_list[@]}; do
        grep -rl --include=*.xml "${i}" $location | grep -v ".bkp" >>${log_file}.goals.${i}.log
    done

    echo "Find files with analysis tools to remove"
    for i in ${analysis_tools_list[@]}; do
        grep -rl --include=*.xml "<${i}>" $location | grep -v ".bkp" >>${log_file}.analysis.${i}.log
    done
    
    grep -r --include=*.xml "<io.jenkins.plugins.analysis.core.steps.IssuesRecorder" $location | grep -v ".bkp" >>${log_file}.analysis.${i}.log
    sed -i "s/:    /,/g" ${log_file}.analysis.log
    
    # Remove duplicates
    cat ${log_file}.goals.*.log | sort | uniq >${log_file}.goals.uniq.log
    cat ${log_file}.analysis.*.log | sort | uniq >${log_file}.analysis.uniq.log

    # Backup config.xml
    f_backup ${log_file}.goals.uniq.log
    f_backup ${log_file}.analysis.uniq.log

    # Remove tags from config.xml
    while read -r file; do
        for i in ${goals_list[@]}; do
            sed -i "s/$i//g" "$file"
        done
    done <${log_file}.goals.uniq.log


    while IFS=, read -r file string; do
            sed -i "/<$string>/,/<\/io.jenkins.plugins.analysis.core.steps.IssuesRecorder>/d" "$file"
    done <${log_file}.analysis.log

    # Add header to log file
    sed -i "1s/^/#### Removed goals from those files ####\n/" ${log_file}.goals.uniq.log
    sed -i "1s/^/#### Removed analysis tools from those files ####\n/" ${log_file}.analysis.uniq.log
    cat ${log_file}.goals.uniq.log ${log_file}.analysis.uniq.log >${log_file}.log
    rm ${log_file}.*.log

    echo "Log: ${log_file}.log"
    echo -e "\e[0;31mFor the changes to take effect, don't forget to Reload Configuration from Disk in Manage Jenkins menu.\e[m"
    ;;
esac
