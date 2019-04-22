#!/bin/bash

# Lets take the configs:
source config
source colors

header="${magenta}[git faker]${nc}"

# just some magic to the script
echo -e "${header} Using the ${red}REMOTE${nc} repo ${remote_repo} for testing"
echo -e "${header} Using the ${yellow}LOCAL${nc} repo ${local_repo} for testing"
cd $local_repo

clear_repository(){
    # Cleaning up
    echo -e "${header} Deleting everything"
    rm -rf .git
    rm *.txt
}

base_init(){

    echo -e "${header} Initializing empty repository"
    git init

    echo -e "${header} Adding remote"
    git remote add origin $remote_repo

    echo -e "${header} Creating first commit"
    echo -e "# Releaser Sample" > README.md
    git add . && git commit -m "First commit - README"
}

create_local_branches(){
    echo -e "${header} Preparing local branches"

    for branch in ${release_pipeline[*]}
    do
        git branch ${branch}
    done
}


create_dummy_commits(){
    echo -e "${header} Creating dummy commits"

    for step in {1..max_objects}
    do
        echo "content ${step}" > "file${step}.txt"
        git add .
        git commit -m "Commit ${step}"
    done
}

push_all_to_remote(){

    echo "${header} Push IT!"

    for branch in ${release_pipeline[*]}
    do
        echo -e "${header} FORCE Pushing origin ${red} $branch ${nc}"
        git push -f origin $branch
    done
}


