#!/usr/bin/env python

import sys
import telnetlib

pkg = sys.argv[1]

print "reinstall through telnet", pkg

HOST = '10.42.0.76'
user = '' #'admin'
password = '' #'admin'

print "connecting to", HOST,
tn = telnetlib.Telnet(HOST)
print "ok"

if user:
    print "waiting for login"
    tn.read_until("login: ")
    tn.write(user + "\n")
if password:
    print "waiting for password"
    tn.read_until("Password: ")
    tn.write(password + "\n")

tn.read_until("spark:~# ")
print "start commands"
tn.write("ipkg update\n")
#print tn.read_all()
tn.write("ipkg remove %s\n" % pkg)
#print tn.read_all()
tn.write("ipkg install %s\n" % pkg)
#print tn.read_all()
tn.write("exit\n")

print tn.read_all()
 
