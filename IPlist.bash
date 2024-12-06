#!/bin/bash
if [ $# -ne 1 ]; then
     echo "Usage: $0 <Prefix>"
     exit 1
fi

prefix=$1

if [ "${#prefix}" -lt 5 ]; then
   echo "Prefix length is too short"
   echo "Prefix example: 10.0.17"
   exit 1
fi

for i in {1..254}; do
    if ping -c 1 -W 1 ${prefix}.${i} | grep -q "64 bytes"; then
        echo "${prefix}.${i}"
    fi
done
