#!/bin/bash

while getopts ":b:p:d:" opt; do
  case $opt in
    b) bucket="$OPTARG"
    ;;
    p) profile="$OPTARG"
    ;;
    d) date="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

files=$(aws s3api list-objects-v2 --bucket ${bucket} \
    --profile ${profile} \
    --query 'Contents[?contains(LastModified, `'"$date"'`)].Key' --output text)

SAVEIFS=$IFS
IFS=$'\t'
values=($files)
IFS=$SAVEIFS

for (( i=0; i<${#values[@]}; i++ ))
do

    if [ ! -e $(dirname "copy_by_date/${values[$i]}") ]; then
        mkdir -p $(dirname "copy_by_date/${values[$i]}")
    fi

    aws s3api get-object --key ${values[$i]} --profile ${profile} \
    --bucket ${bucket} \
    --query 'Contents[?contains(LastModified, `'"$date"'`)].Key' \
    "copy_by_date/${values[$i]}"
done