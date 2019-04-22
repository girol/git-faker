#!/bin/sh

source "$(git --exec-path)/git-sh-setup"

USAGE="INTEGER. INTEGER is the number of fake commits to generate"

_fake_commits(){

    if [[ -n $1 ]]; then
        for ((step=1 ; step<=$1 ; step++)); do
            echo "content ${step}" > "file${step}.txt"
            git add .
            git commit -m "Commit ${step}"
        done

    else
        usage
    fi
}

_fake_commits $1