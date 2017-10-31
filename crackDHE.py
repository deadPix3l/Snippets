#!/usr/bin/env python

import pyDHE

alice = pyDHE.new((2, 541))
bob  = pyDHE.new((2, 541))

A = alice.getPublicKey()
B = bob.getPublicKey()

K = alice.update(B)
assert K == bob.update(A)

p, g = alice.p, alice.g 
a, b = alice.a, bob.a

print('''
Welcome to DiffieCrack!
-----------------------
The goal is to mathematically discover just one of the 
three numbers in the private section, using only public
and inferred (i.e Only what Eve can see). Feel free to 
add more equations to the inferred, but remember:

Don't use any private values. Good Luck!
''')

print('''
Private
--------
a: {}
b: {}
K: {}
------'''.format(a, b, K))

print('''
Public
-------
g: {}
p: {}

A: {}
B: {}
--------'''.format(g, p, A, B))

# ADD you own equations In this block

print('''
Inferred
---------
(A**B) % p: {}
(B**A) % p: {}
----------
'''.format(pow(A, B, p), pow(B, A, p)))

