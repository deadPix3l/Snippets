#!/bin/bash

if [ -f "$CTE_LOGFILE" ] && [ -n "$CTE_CALLSIGN" ]
then

    if [ "$#" -gt 0 ]
    then
        command=$@
    else
        read -p "CTE> " command
    fi

BEFORE=$(date +%s)
# log before execute in case of failure
echo -n "$BEFORE, $command, " >> "$CTE_LOGFILE"

eval "$command"

AFTER=$(date +%s)
echo -n "$AFTER" >> "$CTE_LOGFILE"

read -p "[comments]: " comments
echo ", $comments" >> "$CTE_LOGFILE"

else

echo "Please export CTE_LOGFILE and CTE_CALLSIGN variables, touch CTE_LOGFILE and rerun."
echo "Any commands were not executed because they could not be logged properly"

fi