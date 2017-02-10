#!/usr/bin/env python
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 8080)) # listen on 8080 on all interfaces
s.listen(1)
print "server started"
conn, addr = s.accept()

try:
    print 'Connected by', addr
    while 1:
        data = conn.recv(1024)
        if not data: break
        print "recvd: {0} \t reply: {0} ACK".format(data)
        conn.sendall(data+' ACK')
        
except KeyboardInterrupt: pass
finally:
    print 'Connection terminated', addr
    conn.close()       