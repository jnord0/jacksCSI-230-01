#!/bin/bash

# Input arguments: log file and IOC file
LOG_FILE="$1"
IOC_FILE="$2"

# Output file
OUTPUT_FILE="report.txt"

# Validate input files
if [[ ! -f "$LOG_FILE" || ! -f "$IOC_FILE" ]]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    echo "Error: Log file or IOC file not found."
    exit 1
fi

# Debugging: Print matches from grep
grep -Ff "$IOC_FILE" "$LOG_FILE" > temp_matches.txt

# Process the log file for matches with the IOCs
grep -Ff "$IOC_FILE" "$LOG_FILE" | while read line; do
    echo "$line" | awk '
{
    # Initialize variables
    ip=""
    datetime=""
    page=""
    
    # Extract IP address
    if (match($0, /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)) {
        ip = substr($0, RSTART, RLENGTH)
    }

    # Extract timestamp
    if (match($0, /\[([^\]]+)\]/)) {
        datetime = substr($0, RSTART+1, RLENGTH-2)  # Remove the square brackets
    }

    # Extract requested page URL
    if (match($0, /\"(GET|POST) ([^ ]+)/)) {
        page = substr($0, RSTART+5, RLENGTH-5)  # Skip over "GET " or "POST "
    }

    # Print IP, timestamp, and page URL
    if (ip != "" && datetime != "" && page != "") {
        printf "%s %s %s\n", ip, datetime, page
    }
}
'
done  > "$OUTPUT_FILE"

# Confirm script execution
if [[ -s "$OUTPUT_FILE" ]]; then
    echo "Filtered logs saved to $OUTPUT_FILE"
else
    echo "No matching logs found."
fi
