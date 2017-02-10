#!/usr/bin/env python
import socket
import time

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('127.0.0.1', 8080))
print "Connected!"
try:
	while 1:
		time.sleep(5) # 10 seconds
		s.sendall('BEACON SYN')
		data = s.recv(1024)
		if not data: break
		print 'recvd:', repr(data)
		
except KeyboardInterrupt: pass
finally: 
	print "Done"
	s.close()