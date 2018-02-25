#!/bin/bash
# This script installs the exhaustive list of tools required for a forensics workstation
# This script will only work for Debian Distributions of Linux (Ubuntu, Mint, etc.)
# Author: Kanishk Sharan

# create repositories
echo "deb http://ppa.launchpad.net/sift/stable/ubuntu trusty main" \
  > /etc/apt/sources.list.d/sift-ubuntu-stable-utopic.list
echo "deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu trusty main" \
  > /etc/apt/sources.list.d/tualatrix-ubuntu-ppa-utopic.list

#list of packages
pkglist=="aeskeyfind
afflib-tools
afterglow
aircrack-ng
arp-scan
autopsy
binplist
bitpim
bitpim-lib
bless
blt
build-essential
bulk-extractor
cabextract
clamav
cryptsetup
dc3dd
dconf-tools
dumbpig
e2fslibs-dev
ent
epic5
etherape
exif
extundelete
f-spot
fdupes
flare
flasm
flex
foremost
g++
gcc
gdb
ghex
gthumb
graphviz
hexedit
htop
hydra
hydra-gtk
ipython
kdiff3
kpartx
libafflib0
libafflib-dev
libbde
libbde-tools
libesedb
libesedb-tools
libevt
libevt-tools
libevtx
libevtx-tools
libewf
libewf-dev
libewf-python
libewf-tools
libfuse-dev
libfvde
libfvde-tools
liblightgrep
libmsiecf
libnet1
libolecf
libparse-win32registry-perl
libregf
libregf-dev
libregf-python
libregf-tools
libssl-dev
libtext-csv-perl
libvshadow
libvshadow-dev
libvshadow-python
libvshadow-tools
libxml2-dev
maltegoce
md5deep
nbd-client
netcat
netpbm
nfdump
ngrep
ntopng
okular
openjdk-6-jdk
p7zip-full
phonon
pv
pyew
python
python-dev
python-pip
python-flowgrep
python-nids
python-ntdsxtract
python-pefile
python-plaso
python-qt4
python-tk
python-volatility
pytsk3
rsakeyfind
safecopy
sleuthkit
ssdeep
ssldump
stunnel4
tcl
tcpflow
tcpstat
tcptrace
tofrodos
torsocks
transmission
unrar
upx-ucl
vbindiff
virtuoso-minimal
winbind
wine
wireshark
xmount
zenity
regripper
cmospwd
ophcrack
ophcrack-cli
bkhive
samdump2
cryptcat
outguess
bcrypt
ccrypt
readpst
ettercap-graphical
driftnet
tcpreplay
tcpxtract
tcptrack
p0f
netwox
lft
netsed
socat
knocker
nikto
nbtscan
radare-gtk
python-yara
gzrt
testdisk
scalpel
qemu
qemu-utils
gddrescue
dcfldd
vmfs-tools
mantaray
python-fuse
samba
open-iscsi
curl
git
system-config-samba
libpff
libpff-dev
libpff-tools
libpff-python
xfsprogs
gawk
exfat-fuse
exfat-utils
xpdf
feh
pyew
radare
radare2
pev
tcpick
pdftk
sslsniff
dsniff
rar
xdot
ubuntu-tweak
vim"



#actually install
# first update 
apt-get update

for pkg in ${pkglist}
do
	if (dpkg --list | awk '{print $2}' | egrep "^${pkg}$" 2>/dev/null) ; 
	then
		echo "yeah ${pkg} already installed"
	else
		# try to install
		echo -n "Trying to install ${pkg}..."
		if (apt-get -y install ${pkg} 2>/dev/null) ; then
			echo "+++Succeeded+++"
		else	
			echo "----FAILED----"
		fi
	fi 
done

