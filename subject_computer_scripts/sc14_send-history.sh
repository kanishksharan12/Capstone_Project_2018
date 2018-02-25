# Simple script to send all user bash history files to my Forensic Workstation
# Author: Kanishk Sharan

usage_prompt () {
	echo "usage: $0 "
	echo "Simple script to send user history files to my forensics workstation"
	exit 1
}

if [ $# -gt 0 ] ; then
   usage_prompt
fi

# find only files, filename is .bash_history 
# execute echo, cat, and echo for all files found 
send-log.sh find /home -type f -regextype posix-extended -regex '/home/[a-zA-Z\.]+(/\.bash_history)' -exec echo -e "---dumping history file {} ---\n" \; -exec cat {} \; -exec echo -e "---end of dump for history file {} ---\n" \;
# repeat for the admin user
send-log.sh find /root -type f -maxdepth 1 -regextype posix-extended -regex '/root/\.bash_history' -exec echo -e "---dumping history file {} ---\n" \; -exec cat {} \; -exec echo -e "---end of dump for history file {} ---\n" \;
