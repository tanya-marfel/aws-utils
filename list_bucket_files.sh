#!/bin/bash

while getopts ":b:f:p:" opt; do
  case $opt in
    b) bucket_name="s3://$OPTARG"
    ;;
    p) profile="$OPTARG"
    ;;
    f) file_name="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

aws s3 ls $bucket_name \
--profile $profile --recursive | awk '{$1=$2=$3=""; print $0}' | \
sed 's/^[ \t]*//' | while read -r; do echo "$(dirname $REPLY),$(basename $REPLY)"; done >> $file_name.csv