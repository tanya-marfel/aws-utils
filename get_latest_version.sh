#!/bin/bash

while getopts ":b:p:" opt; do
  case $opt in
    b) bucket="$OPTARG"
    ;;
    p) profile="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

files=$(aws s3 ls s3://subtask1-console --profile administrator --recursive | awk '{print $4}')

SAVEIFS=$IFS
IFS=$'\n'
values=($files)
IFS=$SAVEIFS

for (( i=0; i<${#values[@]}; i++ ))
do
    version=$(aws s3api list-object-versions --bucket ${bucket} \
    --query 'reverse(sort_by(Versions[?'Key'==`'"${values[$i]}"'`], &LastModified))[:1].VersionId' \
    --profile ${profile} --output text)

    if [ ! -e $(dirname "copy/${values[$i]}") ]; then
        mkdir -p $(dirname "copy/${values[$i]}")
    fi

    aws s3api get-object --key ${values[$i]} --profile ${profile} \
    --bucket ${bucket} \
    --version-id $version "copy/${values[$i]}"
done
