#!/bin/bash

# Define the URL of the IOC webpage
IOC_URL="http://10.0.17.6/IOC.html"

# File to save the IOC list
OUTPUT_FILE="IOC.txt"

# Fetch the content of the webpage and extract IOCs from <td> tags
curl -s "$IOC_URL" | grep -oP '(?<=<td>).*?(?=</td>)' | sed -n '1~2p' > "$OUTPUT_FILE"

# Display a message to confirm the script ran successfully
if [ -s "$OUTPUT_FILE" ]; then
    echo "IOCs successfully saved to $OUTPUT_FILE"
else
    echo "No IOCs found or unable to fetch the web page."
fi
