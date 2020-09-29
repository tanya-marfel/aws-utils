#!/bin/bash

while getopts ":b:f:p:" opt; do
  case $opt in
    b) bucket="s3://$OPTARG"
    ;;
    p) profile="$OPTARG"
    ;;
    f) folder="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

fswatch ${folder} | xargs -n1 -I{} aws s3 sync ${folder} ${bucket} \
--exclude ".git/*" \
--exclude ".DS_Store" \
--exclude ".DS_Store?" \
--exclude "._*" \
--exclude "node_modules/*" \
--delete \
--profile ${profile}