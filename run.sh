#!/bin/bash

# Lets take the configs:
source config
source colors

header="${magenta}[git faker]${nc}"

# just some magic to the script
echo -e "${header} Using the ${red}REMOTE${nc} repo ${remote_repo} for testing"
echo -e "${header} Using the ${yellow}LOCAL${nc} repo ${local_repo} for testing"
cd $local_repo

# Cleaning up
echo -e "${header} Deleting everything"
rm -rf .git
rm *.txt

echo -e "${header} Initializing empty repository"
git init

echo -e "${header} Adding remote"
git remote add origin $remote_repo

echo -e "${header} Creating first commit"
echo -e "# Releaser Sample" > README.md
git add . && git commit -m "First commit - README"

echo -e "${header} Preparing branches"
git branch testing
git branch beta
git branch production

echo -e "${header} Listing Branches"
git branch

echo -e "${header} Creating dummy commits"

for step in 1 2 3
do
    echo "content ${step}" > "file${step}.txt"
    git add .
    git commit -m "Commit ${step}"
done

echo "${header} Push IT!"

for branch in ${release_pipeline[*]}
do
    echo -e "${header} Pushing ${red} $branch ${nc}"
    git push -f origin $branch
done

