# nmap-parser

**LATEST VERSION 0.9**

My first script posted script to github (:

A handy script thats becomming a swiss army knife for dealing with greppable nmap output. 


## Features

* Display a list of alive and dead hosts
* Generate 3 types of reports
* List unqiue ports
* List hosts
* Produces stats on hosts, ports and services
* Parse IP:PORT to pipe into tools

## To Do / Want to add

* A single decent report function
* Tidy the script up
* Start and finish time in stats
* nmap 2 csv
* nmap 2 nessusfile
* search / filter options
* other cool stuff
* list clear-text protocols
* list services with versions like web, databases stuff that can be checkd for patching

# Usage

```
# ./nmap-parser.sh -f [greppable nmapfile] [options]

```

## Examples


```
./nmap-parser.sh -f *.gnmap -h


 ███╗   ██╗███╗   ███╗ █████╗ ██████╗       ██████╗  █████╗ ██████╗ ███████╗███████╗██████╗ 
 ████╗  ██║████╗ ████║██╔══██╗██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
 ██╔██╗ ██║██╔████╔██║███████║██████╔╝█████╗██████╔╝███████║██████╔╝███████╗█████╗  ██████╔╝
 ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ ╚════╝██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══╝  ██╔══██╗
 ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║           ██║     ██║  ██║██║  ██║███████║███████╗██║  ██║
 ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝

Version: 0.7
---------------------------------------------------------------------------------------------
 
Usage: 
    ./nmap-parser.sh -f [gnmap file] [options] 
 
Options:  
  -h    Show this help message and exit
  -u    IP - List up hosts - ping
  -d    IP - List down hosts - ping
  -p    PORT1,PORT2,PORT3,.. - List Unique open ports 
  -v    SERVICE1,SERVICE2,SERVICE3,.. - List Unique services for open ports
  -s    Stats - Numbers on open ports, alive hosts est
  -ir   IP:PORT - List alive hosts and ports (useful to pipe into other tools)
  -r    IP:PROTOCOL:PORT:STATUS:SERVICE - List alive hosts, ports and ports
  -r1   Report - Basic clean report
  -r2   Report - IP[PORT1,PORT2, ] - parsip.pl
  -r3   Report **TESTING**

---------------------------------------------------------------------------------------------



./nmap-parser.sh -f *.gnmap -r
192.168.0.1:tcp:1900:upnp:open:MiniUPnP 1.7 (Fedora Core 6; UPnP 1.1)
192.168.0.1:tcp:49152:http:open:Linksys E8350 WAP or TP-LINK router
192.168.0.1:tcp:53:domain:open:dnsmasq 2.56
192.168.0.1:tcp:80:http:open:mini_httpd 1.19 19dec2003
192.168.0.10:tcp:443:ssl|http:open:VMware VirtualCenter Web service
192.168.0.10:tcp:902:ssl|vmware-auth:open:VMware Authentication Daemon 1.10 (Uses VNC
192.168.0.10:tcp:912:vmware-auth:open:VMware Authentication Daemon 1.0 (Uses VNC



./nmap-parser.sh -f *.gnmap -p
1900,443,49152,53,80,902,912



./nmap-parser.sh -f *.gnmap -v
domain,http ssl|http,ssl|vmware-auth upnp,vmware-auth



./nmap-parser.sh -f *.gnmap -ir
192.168.0.10:443
192.168.0.10:902
192.168.0.10:912
192.168.0.1:1900
192.168.0.1:49152
192.168.0.1:53
192.168.0.1:80



./nmap-parser.sh -f *.gnmap -s
File: nmap_tcp_def_192.168.0.X.gnmap

Total Hosts Scanned:  4

Alive Hosts: 4
---------------------
192.168.0.1
192.168.0.10
192.168.0.14
192.168.0.4
---------------------

Dead Hosts:    0
---------------------
---------------------

Total Open ports:  7
---------------------
   53:    1
   80:    1
 1900:    1
49152:    1
  443:    1
  902:    1
  912:    1
---------------------

Unique Ports:  7
---------------------
1900,443,49152,53,80,902,912
---------------------
 
Unique Services:
---------------------
domain,http ssl|http,ssl|vmware-auth upnp,vmware-auth
```
