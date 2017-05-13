# nmap-parser

**LATEST VERSION 0.7**

My first script posted script to github.

A handy script for parsing greppable nmap output. various ways to wrestle with nmap for 	



## Features

* Display a list of alive and dead hosts
* Generate 3 types of reports
* List unqiue ports
* List hosts
* Produces stats on hosts, ports and services

## To Do

* A single decent report function
* Tidy the script up
* nmap 2 csv
* nmap 2 nessus
* search / filter options
* other cool stuff
* list clear-text protocols
* list services with versions like web, databases stuff that can be checkd for patching

# Usage

```
# ./nmap-parser.sh -f [greppable nmapfile] [options]

```



```
./nmap-parser.sh 


 ███╗   ██╗███╗   ███╗ █████╗ ██████╗       ██████╗  █████╗ ██████╗ ███████╗███████╗██████╗ 
 ████╗  ██║████╗ ████║██╔══██╗██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
 ██╔██╗ ██║██╔████╔██║███████║██████╔╝█████╗██████╔╝███████║██████╔╝███████╗█████╗  ██████╔╝
 ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ ╚════╝██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══╝  ██╔══██╗
 ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║           ██║     ██║  ██║██║  ██║███████║███████╗██║  ██║
 ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝

Version: 0.7
---------------------------------------------------------------------------------------------
 
Usage: ./nmap-parser.sh -f [gnmap file] [options] 
  Run inside nmap output dir it will pickup *.gnamp
  If no file is specificed the script will look for *.gnmap in pwd
 
Options:  
  -h    Show this help message and exit
  -u    List live hosts from an nmap PingScan
  -d    List dead hosts from an nmap PingScan
  -p    Will list unique open ports from nmap TCP and UDP good to feed into Nessus
  -s    Will produce a little stat report, total open ports est.
  -ir   output IP:PORT - list of alive ip and open port which can be piped into other tools, 
  -r   report prints IP:PROTOCOL:PORT:STATUS:SERVICE
  -r1   report2 basic output from nmap Cleaned up report live hosts with open ports from nmap TCP and UDP
  -r2   Will geberate a report  of live IPS - parsip.pl
  -r3   another report testing

---------------------------------------------------------------------------------------------
 
**No options provided!**

```