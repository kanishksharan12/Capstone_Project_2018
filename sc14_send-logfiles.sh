# This script sends all logs to my forensics workstation.
# Author: Kanishk Sharan

usage () {
	echo "usage: $0 "
	echo "Simple script to send log files to my forensics workstation"
	exit 1
}

if [ $# -gt 0 ] ; then
   usage
fi

# find only files, exclude files with numbers as they are old logs 
# execute echo, cat, and echo for all files found 
send-log.sh find /var/log -type f -regextype posix-extended -regex '/var/log/[a-zA-Z\.]+(/[a-zA-Z\.]+)*' -exec echo -e "---dumping logfile {} ---\n" \; -exec cat {} \; -exec echo -e "---end of dump for logfile {} ---\n" \;
