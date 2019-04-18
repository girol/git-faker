#!/bin/bash

# Lets take the configs:

source config

# A common pipeline for code deployment
release_pipeline=('master' 'testing' 'beta' 'production')

echo "Using the repo ${remote_repo} for testing"

cd $local_repo

# Cleaning up
echo "Deleting everything"
rm -rfv .git
rm *.txt

echo "Initializing empty repository"
git init

echo "Adding remote"
git remote add origin $remote_repo

echo "Creating first commit"
echo "# Releaser Sample" > README.md
git add . && git commit -m "First commit - README"

echo "Preparing branches"
git branch testing
git branch beta
git branch production

echo "Listing Branches"
git branch

echo "Creating dummy commits"

for step in 1 2 3
do
    echo "stage ${step}" > "file${step}.txt"
    git add .
    git commit -m "Commit ${step}"
done

echo "Push IT!"

for branch in ${release_pipeline[*]}
do
    git push -f origin $branch
    echo $branch
done

