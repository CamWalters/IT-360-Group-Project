#!/bin/bash

#Defines our output txt file name.
OUTPUT="login_history.txt"

#Displays that results are being written to the output file for user.
echo "[+] Writing login history to $OUTPUT"

{
    #Section header for Successful Logins section.
    echo "===== SUCCESSFUL LOGINS ====="
    #Last command will pull all successful login attempts via the /var/log/wtmp file.
    last
    echo

    #Section header for Failed Logins section.
    echo "===== FAILED LOGINS ====="
    #Journalctl is used to search system logs for three criteria of failure messages (failed password, invalid user
    #and authentication failure).
    #Command uses sudo, meaning the user will have to use sudo privileges for the script
    sudo journalctl --no-pager | grep -Ei "failed password|invalid user|authentication failure" 2>/dev/null
    echo

    #Section header for Local Authentication Attempts.
    echo "===== LOCAL AUTHENTICATION ATTEMPTS ===="
    #This command will show authenticated related journal entries (session open/close, login failures)
    #excluding sudo entries.
    sudo journalctl --no-pager \
    | grep Ei "session opened|session closed|authentication failure|invalid user|failed password" \
    | grep -vi sudo
    echo
    
#Sends all collected output to the output file.
} > "$OUTPUT"

#This command displays the output file to the user.
cat "$OUTPUT"
#This line notifies the user that the information displayed has also been saved to the txt file.
echo "This information has also been saved into login_history.txt"

#Displays that the script is done and output has been saved to the output file for the user.
echo "[+] Done. Output saved to: $OUTPUT"


