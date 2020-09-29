# Launch guide

## sync_with_bucket.sh
This script listens to the changes in the specified directory and sends them to S3. You can start it as follows
```
bash sync_with_bucket.sh -p administrator -b subtask1-console -f build
```
where -p is AWS profile to use, -b is the name of the bucket and -f is the folder name to watch

## list_bucket_files.sh
Lists the bucket files into csv file, e.g. 
```
bash list_bucket_files.sh -p administrator -b subtask1-console -f test
```
where -p is AWS profile to use, -b is the name of the bucket and -f is the csv file name

## get_latest_versions.sh
Downloads most recent versions of the files in the bucket
```
bash get_latest_version.sh -p administrator -b subtask1-console
```
where -p is AWS profile to use, -b is the name of the bucket

## get_by_date.sh
Downloads all the files from the bucket modified on the specified date, e.g. 
```
get_by_date.sh -p administrator -b subtask1-console -d 2020-09-28
```
where -p is AWS profile to use, -b is the name of the bucket and -d is the date to compare against. The format is YYYY-MM-DD.