#!/usr/bin/env python
import bs4
import requests

def getwordtypes(word):
    entire_page = requests.get("http://www.dictionary.com/browse/{}".format(word)).text
    soup = bs4.BeautifulSoup(entire_page, "html5lib")
    main_word = soup.find(class_="def-list")
    
    if main_word == None: return []
    types = main_word.find_all('span', class_="dbox-pg")
    # types = main_word.find_all('header', class_="luna-data-header")
    
    return [i.string for i in types]
    
if __name__=="__main__":
    x = raw_input("enter a word: ")
    print getwordtypes(x)
