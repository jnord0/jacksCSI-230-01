#!/bin/bash

# This is the link we will scrape
link="10.0.17.6/Assignment.html"

# Fetch the webpage with curl
fullPage=$(curl -sL "$link")

# Extract and clean rows from the Temperature Read table (first table)
temperatureData=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of "//html//body//table[1]//tr" | \
sed 's/<\/tr>/\n/g' | \
sed -e 's/<tr>//g' -e 's/<th[^>]*>//g' -e 's/<\/th>//g' | \
sed -e 's/<td[^>]*>//g' -e 's/<\/td>/;/g' -e 's/<[/\]\{0,1\}a[^>]*>//g' -e 's/<[/\]\{0,1\}nobr>//g' | \
sed 's/&#13;//g' | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | sed -E 's/[[:space:]]+/ /g' | grep -v '^[[:space:]]*$')

pressureData=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of "//html//body//table[2]//tr" | \
sed 's/<\/tr>/\n/g' | \
sed -e 's/<tr>//g' -e 's/<th[^>]*>//g' -e 's/<\/th>//g' | \
sed -e 's/<td[^>]*>//g' -e 's/<\/td>/;/g' -e 's/<[/\]\{0,1\}a[^>]*>//g' -e 's/<[/\]\{0,1\}nobr>//g' | \
sed 's/&#13;//g' | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | sed -E 's/[[:space:]]+/ /g' | grep -v '^[[:space:]]*$')

paste -d " " <(echo "$pressureData" | cut -d ';' -f1) <(echo "$temperatureData" | cut -d ';' -f1) | \
awk -F ';' '{ printf "%-10s %-15s %-25s\n", $1, $2, $3 }'
