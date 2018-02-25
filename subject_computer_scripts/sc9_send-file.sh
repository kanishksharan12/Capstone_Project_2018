# This script sends file from the subject computer to my Linux Forensics Workstation
# Author: Kanishk Sharan

# defaults primarily for testing
[ -z "$RHOST" ] && { export RHOST=localhost; }
[ -z "$RPORT" ] && { export RPORT=4444; }
[ -z "$RFPORT" ] && { export RFPORT=5555; }
[ -z "$RFTPORT" ] && { export RFTPORT=5556; }

usage_prompt () { 
	echo "usage: $0 <filename>"
	echo "This script sends suggested file to listener (Forensic Workstation)"
	exit 1
}

# did you specify a file?
if [ $# -lt 1 ] ; then
   usage_prompt
fi

#log it
echo "Attempting to send file $1 at $(date)" | nc $RHOST $RPORT
#send name
echo $(basename $1) | nc $RHOST $RFPORT
#give it time
sleep 5
nc $RHOST $RFTPORT < $1


