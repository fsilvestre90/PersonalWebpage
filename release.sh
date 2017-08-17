#!/bin/bash

msg="Rebuilding Site `date`"
clean=0

# read command line options
while getopts 'm:c' flag; do
  case "${flag}" in
    m) msg="${OPTARG}" ;;
    c) clean=1 ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

# clean up existing build if -c was provided
if [ $clean -eq 1 ]
  then cd dist
  echo -e "Cleaning up dist/ directory..."
  rm -rf *
  cd ..
fi

# build site and commit
echo -e "\033[0;32mCommitting to github...\033[0m"
git add -A
git commit -s -m "$msg"

# push site to remote repo
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
git push origin master
