#!/bin/bash

OUTPUT="login_history.txt"

echo "[+] Writing login history to $OUTPUT"

{
    echo "===== SUCCESSFUL LOGINS (last) ====="
    last
    echo

    echo "===== FAILED LOGINS (journalctl) ====="
    sudo journalctl --no-pager | grep -Ei "failed password|invalid user|authentication failure" 2>/dev/null
    echo

    echo "===== CURRENT ACTIVE SESSIONS (who) ====="
    who
    echo
} > "$OUTPUT"

echo "[+] Done. Output saved to: $OUTPUT"


