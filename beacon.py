#!/usr/bin/env python
import argparse
import socket
import time
    
parser = argparse.ArgumentParser(description='Beacon is a simple script to test connections.')
parser.add_argument('host', nargs='?', help="the host to connect to", default="127.0.0.1")
parser.add_argument('-s', '--server', help='Server mode [default: no]', action="store_true")
parser.add_argument('-p', '--port', help='Port server is listening on', type=int, default=8080)
parser.add_argument('-b', '--beacon', help='Text to send to server', default="beacon")
parser.add_argument('-i', '--interval', help="sleep interval", type=int, default=5)
args = parser.parse_args()

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
if args.server:
    s.bind((args.host, args.port))
    s.listen(1)
    print "server started"
    conn, addr = s.accept()
    s.close()
    
else:
    s.connect((args.host, args.port))
    conn = s
    addr = args.host

try:
    print 'Connected to', addr
    if args.server:
        while True:
            data = conn.recv(1024)
            if not data: break
            print "recvd: {0} \t reply: {0} ACK".format(data)
            conn.sendall(data + ' ACK')
            
    else:
        while True:
            time.sleep(5)
            conn.sendall(args.beacon)
            data = s.recv(1024)
            if not data: break
            print 'recvd: {}'.format(data)
            
except KeyboardInterrupt: pass
finally:
    print 'Connection terminated', addr
    conn.close()