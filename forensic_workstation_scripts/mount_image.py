#!/usr/bin/python


import sys
import os.path
import subprocess

class MbrRecord():
   def __init__(self, sector, partno):
      self.partno = partno
      offset = 446 + partno * 16
      self.active = False
      if sector[offset] == '\x80':
         self.active = True
      self.type = ord(sector[offset+4])
      self.empty = False
      if self.type == 0:
         self.empty = True
      self.start = ord(sector[offset+8]) + ord(sector[offset+9]) * 256 + \
         ord(sector[offset+10]) * 65536 + ord(sector[offset+11]) * 16777216 
      self.sectors = ord(sector[offset+12]) + ord(sector[offset+13]) * 256 + \
         ord(sector[offset+14]) * 65536 + ord(sector[offset+15]) * 16777216
   
   def printPart(self):
      if self.empty == True:
         print("<empty>")
      else:
         outstr = "" 
         if self.active == True:
            outstr += "Bootable:"
         outstr += "Type " + str(self.type) + ":"
         outstr += "Start " + str(self.start) + ":"
         outstr += "Total sectors " + str(self.sectors)
         print(outstr)

def usage():
   print("usage " + sys.argv[0] + " <image file>\nAttempts to mount partitions from an image file")
   exit(1)

def main():
  if len(sys.argv) < 2: 
     usage()
  # read first sector
  if not os.path.isfile(sys.argv[1]):
     print("File " + sys.argv[1] + " cannot be openned for reading")
     exit(1)
  with open(sys.argv[1], 'rb') as f:
    sector = str(f.read(512))
    
  if (sector[510] == "\x55" and sector[511] == "\xaa"):
     print("Looks like a MBR or VBR")
     # if it is an MBR bytes 446, 462, 478, and 494 must be 0x80 or 0x00
     if (sector[446] == '\x80' or sector[446] == '\x00') and \
        (sector[462] == '\x80' or sector[462] == '\x00') and \
        (sector[478] == '\x80' or sector[478] == '\x00') and \
        (sector[494] == '\x80' or sector[494] == '\x00'):
        print("Must be a MBR")
        parts = [MbrRecord(sector, 0), MbrRecord(sector, 1), \
           MbrRecord(sector, 2), MbrRecord(sector, 3)]
        for p in parts:
           p.printPart()
           if not p.empty:
              notsupParts = [0x05, 0x0f, 0x85, 0x91, 0x9b, 0xc5, 0xe4, 0xee]
              if p.type in notsupParts:
                 print("Sorry GPT and extended partitions are not supported by this script!")
              else:
                 mountpath = '/media/part%s' % str(p.partno)
                 if not os.path.isdir(mountpath):
                    subprocess.call(['mkdir', mountpath])
                 mountopts = 'loop,ro,noatime,offset=%s' % str(p.start * 512)
                 subprocess.call(['mount', '-o', mountopts, sys.argv[1], mountpath])
     else:
        print("Appears to be a VBR\nAttempting to mount")
        if not os.path.isdir('/media/part1'):
           subprocess.call(['mkdir', '/media/part1'])
        subprocess.call(['mount', '-o', 'loop,ro,noatime', sys.argv[1], '/media/part1'])
 
if __name__ == "__main__":
   main()

