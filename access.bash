#!/bin/bash

# Log the file access event
echo "$(date): File 'userlogs.bash' was accessed" >> /home/champuser/jacksCSI-230-01/week14/fileaccesslog.txt

# Email the log file using ssmtp
{
  echo "To: recipient_email@example.com"
  echo "From: your_email@gmail.com"
  echo "Subject: File Access Alert"
  echo
  cat /home/champuser/jacksCSI-230-01/week14/fileaccesslog.txt
} | ssmtp jack.nordberg@mymail.champlain.edu

