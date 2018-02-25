# This script collects basic file information from the Subject Computer as a part of the initial live analysis
# Sends the collected information back to my Forensics Workstation 
# Author: Kanishk Sharan

usage () {
	echo "usage: $0 <starting directory>"
	echo "Simple script to send file information to my forensics workstation"
	exit 1
}

if [ $# -lt 1 ] ; then
   usage
fi

# semicolon delimited file which makes import to spreadsheet easier
# printf is access date, access time, modify date, modify time,
#           create date, create time, permissions, user id, user name,
#           group id, group name, file size, filename and then line feed
send-log.sh find $1 -printf "%Ax;%AT;%Tx;%TT;%Cx;%CT;%m;%U;%u;%G;%g;%s;%p\n"
