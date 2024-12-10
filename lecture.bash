#!bin/bash

file="/var/log/apache2/access.log"

countingCurlAccess() {

     cat "$file" | cut -d' ' -f1 | sort | uniq -c
}

countingCurlAccess
