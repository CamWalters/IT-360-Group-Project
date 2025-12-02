#!/bin/bash

#Defines our output txt file name.
OUTPUT="login_history.txt"

#Displays that results are being written to the output file for user.
echo "[+] Writing login history to $OUTPUT"

{
    #Section header for Successful Logins section.
    echo "===== SUCCESSFUL LOGINS (last) ====="
    #Last command will pull all successful login attempts via the /var/log/wtmp file.
    last
    echo

    #Section header for Failed Logins section.
    echo "===== FAILED LOGINS (journalctl) ====="
    #Journalctl is used to search system logs for three criteria of failure messages (failed password, invalid user
    #and authentication failure).
    #Command uses sudo, meaning the user will have to use sudo privileges for the script
    sudo journalctl --no-pager | grep -Ei "failed password|invalid user|authentication failure" 2>/dev/null
    echo
#Sends all collected output to the output file.
} > "$OUTPUT"
#Displays that the script is done and output has been saved to the output file for the user.
echo "[+] Done. Output saved to: $OUTPUT"


