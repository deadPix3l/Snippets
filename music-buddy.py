#!/usr/bin/env python
import os
import json
import urllib2

#directory where music is contained
library = "Music";

# queries US iTunes store for artists, and albums. documentation found at:
# https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html
findartists = "https://itunes.apple.com/search?country=US&limit=1&media=music&entity=musicArtist&attribute=artistTerm&term=";
lookupalbums = "https://itunes.apple.com/lookup?entity=album&id=";

#os.walk() will return a generator for tuple: (directory, subdirs, files)
#next() will return the first element from generator [0]
#sorted will return a sorted list (because os.walk is in a random, arbitrary order)
#full line: will return list of all direct child dirs, sorted alphebetically
#assuming children folders in $library are band names
for artist in sorted(os.walk(library).next()[1]):

	# quote special chars (notably space: 0x20) and read response
	response = urllib2.urlopen(findartists+urllib2.quote(artist)).read();
	allartists = json.loads(response); #parse it
	
	# assume first artist returned is correct
	# This may not always be the case, but it seems to work pretty well.
	artistID = str(allartists['results'][0]['artistId']);
	
	print '\n%s (id: %s)' % (artist, artistID);
	print '---------------';
	
	# fetch all albums from artistID
	response = urllib2.urlopen(lookupalbums+artistID).read();
	albums = json.loads(response); #parse it
	
	#save local and iTunes versions
	local = os.walk(library+'/'+artist).next()[1];
	iTunes = [];
	for i in albums['results']:
		#not an album, don't care! (also, keyerrors!)
		if i['wrapperType'] != "collection": continue;
		
		#add all relevant album info ([:4] = year only) 
		iTunes.append('('+i['releaseDate'][:4]+') - ' + i['collectionName']);
	
	#make a list of all albums in iTunes, that aren't in local library
	missingAlbums = sorted([x for x in iTunes if x not in local]);
	for x in missingAlbums:
		print x;