#!/usr/bin/env python

# Skyler Curtis (@deadPix3l)
# 26 OCT 16
# gallery unlock v1

# a simple script for generatinga ducky script file
# this is designed to quickly brute force open those terrible "picture vault" type apps, 
# specifically "gallery lock"
# currently it just displays junk. v2 will print valid ducky script
# hopefully v3 will skip duck encoder and create a bin file

key = "0123456789"

def recurse(key,codelen,i=0):
	if i<codelen:
		for x in key:
			print x,
			recurse(key,codelen,i+1)
		print '\\b'
	else: print '\\b',

if __name__ == "__main__":
	recurse(key,4)

