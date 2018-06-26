#!/usr/bin/env python
import random

'''
 A simple fuzzer to create fake hashes, IPs, MACs, phone numbers, etc.
 for when the data is meaningless, but must LOOK valid for testing.

eventually may add support for (as needed):
   - Cisco TYPE 7
   - NTLM
   - Phone Numbers (of various countries)
   - email addresses
   - Base64
   - IPv6 shortening (ab::1:2222)
   - etc.

'''
def macAddr():
  return ':'.join('{:02x}'.format(random.getrandbits(8)) for i in range(6))

def ipv4():
  return '.'.join('{:d}'.format(random.getrandbits(8)) for i in range(4))

def ipv6():
  return ':'.join('{:x}'.format(random.getrandbits(16)) for i in range(8))

def md5():
    return '{:032x}'.format(random.getrandbits(128))

def sha1():
    return '{:040x}'.format(random.getrandbits(160))

def sha256():
    return '{:064x}'.format(random.getrandbits(256))
