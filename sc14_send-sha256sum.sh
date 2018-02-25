# Simple script to calculate sha256 sum 
# Author: Kanishk Sharan

usage () {
	echo "usage: $0 <starting directory>"
	echo "Simple script to send SHA256 hash to my forensics workstation"
	exit 1
}

if [ $# -lt 1 ] ; then
   usage
fi

# find only files, don't descend to other filesystems, 
# execute command sha256sum -b <filename> for all files found 
send-log.sh find $1 -type f -xdev -exec sha256sum -b {} \;
