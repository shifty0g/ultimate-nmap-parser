# nmap-parser

**LATEST VERSION 0.6**

My first script posted script to github.

A handy script for parsing greppable nmap output.



## Features

* Display a list of alive and dead hosts
* Generate 3 types of reports
* List unqiue ports
* List hosts
* Produces stats on hosts and ports

## To Do


# Usage

```
# ./nmap-parser.sh


███╗   ██╗███╗   ███╗ █████╗ ██████╗       ██████╗  █████╗ ██████╗ ███████╗███████╗██████╗
████╗  ██║████╗ ████║██╔══██╗██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
██╔██╗ ██║██╔████╔██║███████║██████╔╝█████╗██████╔╝███████║██████╔╝███████╗█████╗  ██████╔╝
██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ ╚════╝██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══╝  ██╔══██╗
██║ ╚████║██║ ╚═╝ ██║██║  ██║██║           ██║     ██║  ██║██║  ██║███████║███████╗██║  ██║
╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝

Version: 0.6
---------------------------------------------------------------------------------------------

Usage: ./nmap-parser.sh [options] [gnmap file]
 Run inside nmap output dir it will pickup *.gnamp
 If no file is specificed the script will look for *.gnmap in pwd

Options:  
 -help       Show this help message and exit
 -uphosts    List live hosts from an nmap PingScan
 -dnhosts    List dead hosts from an nmap PingScan
 -preport    Ping report from PingScan
 -report     Cleaned up report live hosts with open ports from nmap TCP and UDP
 -report2    Another report just looks different
 -report3    Another third report
 -au         Will list all uniqe hosts, ports and services that are alive and open
 -uports     Will list unique open ports from nmap TCP and UDP good to feed into Nessus
 -iplist     Will produce same outpout as nmap-parse
 -parsip     Will parse out a list of live IPS - parsip.pl
 -ipreport   List of alive ip and open port which can be piped into other tools, IP:PORT
 -stats      Will produce a little stat report, total open ports est.

---------------------------------------------------------------------------------------------

**No options provided!**


```
