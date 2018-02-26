# This script collects basic information from the Subject Computer as a part of the initial live analysis
# Sends the log entry back to my Forensics Workstation 
# Author: Kanishk Sharan

usage_prompt () {
	echo "usage: $0 [listening host]"
	echo "Simple script to send a log entry to my forensics workstation"
	exit 1
}

# did you specify a listener IP?
if [ $# -gt 1 ] || [ "$1" == "--help" ] ; then
   usage_prompt
fi

# did you specify a listener IP?
if [ "$1" != "" ] ; then
   source sc9_setup-client.sh $1
fi

# now collect some info!
send-log.sh date 
send-log.sh uname -a
send-log.sh ifconfig -a
send-log.sh netstat -anp
send-log.sh lsof -V
send-log.sh ps -ef
send-log.sh netstat -rn
send-log.sh route
send-log.sh lsmod
send-log.sh df
send-log.sh mount
send-log.sh w
send-log.sh last 
send-log.sh cat /etc/passwd
send-log.sh cat /etc/shadow

