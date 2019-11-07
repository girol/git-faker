#!/bin/bash

source $(git --exec-path)/git-sh-setup


USAGE="INTEGER. INTEGER is the number of fake commits to generate"

_prompt_user(){

    while true; do

        echo "This wil generate AND commit $1 files. Proceed? [y/n] "
        read choice
        case $choice in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

_fake_commits(){

    if [[ -n $1 ]]; then
        _prompt_user
        for ((step=1 ; step<=$1 ; step++)); do
            timestamp=$(date '+%Y-%m-%d %H:%M:%S')
            echo "content ${timestamp}" > "file${step}.txt"
            git add .
            git commit -m "Commit ${timestamp}"
        done

    else
        usage
    fi
}

_fake_commits $1
