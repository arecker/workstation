#!/usr/bin/env bash

echo "The screensaver is disabled!  Just close this terminal window when you are done with the computer."

while true; do
    xscreensaver-command --deactivate &> /dev/null
    sleep 10
done
