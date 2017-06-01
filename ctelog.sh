#!/bin/bash

if [ -f "$CTE_LOGFILE" ] && [ -n "$CTE_CALLSIGN" ]
then


    TODAY=$(date +%d%b%y)
    BEFORE=$(date +%H%M)
    
    if [ "$#" -gt 0 ]
    then
        command=$@
        # log before execute in case of failure
        echo -ne "$CTE_CALLSIGN\t$TODAY\t$BEFORE\t$command\t" >> "$CTE_LOGFILE"
        eval "$command"
        
    else
        read -p "action> " command
        echo -ne "$CTE_CALLSIGN\t$TODAY\t$BEFORE\t$command\t" >> "$CTE_LOGFILE"
    fi

AFTER=$(date +%H%M)
echo -n "$AFTER" >> "$CTE_LOGFILE"

read -p "[result]: " result
read -p "[comments]: " comments
echo -e "\t$result\t$comments" >> "$CTE_LOGFILE"

else

echo "Please export CTE_LOGFILE and CTE_CALLSIGN variables, touch CTE_LOGFILE and rerun."
echo "Any commands were not executed because they could not be logged properly"

fi