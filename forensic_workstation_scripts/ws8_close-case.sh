#!/bin/bash
# This script starts shuts down listeners on my forensics workstation
# Author: Kanishk Sharan 


echo "Shutting down listeners at $(date) at user request" | nc localhost 4444
killall start-case.sh
killall start-file-listener.sh
killall nc

