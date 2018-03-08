#!/bin/bash
# Author: Kanishk Sharan

: '
Simple shell script to extract MAC times from an image to
a CSV file. This can further be import into a spreadsheet.
'

usage_type () {
	echo "usage: $0 <starting directory>"
	echo "Simple script to get MAC times from an image and output CSV"
	exit 1
}

if [ $# -lt 1 ] ; then
   usage_type
fi

: '
semicolon delimited file which makes import to spreadsheet easier printf is access date, access time, modify date, modify time,
create date, create time, permissions, user id, user name, group id, group name, file size, filename and then line feed
'

olddir=$(pwd)
cd $1 # this avoids having the mount point added to every filename
printf "Access Date;Access Time;Modify Date;Modify Time;Create Date;Create Time;Permissions;User ID;Group ID;File Size;Filename\n"
find ./ -printf "%Ax;%AT;%Tx;%TT;%Cx;%CT;%m;%U;%G;%s;%p\n"
cd $olddir
