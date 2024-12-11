#!/bin/bash

# Input file
INPUT_FILE="report.txt"

# Output HTML file
HTML_FILE="/var/www/html/report.html"

# Validate input file
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

# Start creating the HTML content
echo "Generating HTML report..."
cat << EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Access logs with IOC indicators</h1>
    <p>Generated from <code>report.txt</code></p>
    <table>
        <tr>
            <th>IP Address</th>
            <th>Date/Time</th>
            <th>Page URL</th>
        </tr>
EOF

# Add table rows from the report file
while IFS= read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    datetime=$(echo "$line" | awk '{print $2}')
    url=$(echo "$line" | awk '{print $3}')
    
    # Add the row to the HTML table
    echo "        <tr><td>$ip</td><td>$datetime</td><td>$url</td></tr>" >> "$HTML_FILE"
done < "$INPUT_FILE"

cat << EOF >> "$HTML_FILE"
    </table>
</body>
</html>
EOF

if mv "$HTML_FILE" /var/www/html/; then
    echo "HTML report successfully moved to /var/www/html/report.html"
    echo "You can access the report at: http://localhost/report.html"
else
    echo "Error: Failed to move the HTML report to /var/www/html/"
    exit 1
fi
