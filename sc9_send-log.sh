# This script sends log entry file from the subject computer to my Linux Forensics Workstation
# Author: Kanishk Sharan

# defaults primarily for testing
[ -z "$RHOST" ] && { export RHOST=localhost; }
[ -z "$RPORT" ] && { export RPORT=4444; }

usage_prompt () {
	echo "usage: $0 <command or script>"
	echo "This script sends suggested log file to listener (Forensic Workstation)"
	exit 1
}

# did you specify a command?
if [ $# -lt 1 ] ; then
   usage_prompt
else
   echo -e "++++Sending log for $@ at $(date) ++++\n $($@) \n----end----\n"  | nc $RHOST $RPORT 
fi 




