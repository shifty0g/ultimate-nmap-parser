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


## Example output

### nmap-parser.sh -uphosts
```
192.168.0.1
192.168.0.10
192.168.0.14
192.168.0.4
```

### nmap-parser.sh -stats
```
File used: nmap_tcp_def_192.168.0.X.gnmap
---------------------
Hosts Up           :  4
Hosts Down         :  0
Total Hosts        :  4
----------------------
Total Open Ports on Live Hosts:
---------------------
1900,443,49152,53,80,902,912
---------------------
 1900:    1
  443:    1
49152:    1
   53:    1
   80:    1
  902:    1
  912:    1
---------------------
```

### nmap-parser.sh -au
```
Unique hosts list
---------------------
192.168.0.1
192.168.0.10
192.168.0.14
192.168.0.4

Unique open port list
---------------------
1900,443,49152,53,80,902,912

Unique services list
---------------------
domain,http ssl|http,ssl|vmware-auth upnp,vmware-auth
```

### nmap-parser.sh -preport
```
File: nmap_tcp_def_192.168.0.X.gnmap

[0]Dead Hosts:
---------------------
---------------------
[4]Alive Hosts:
---------------------
192.168.0.1
192.168.0.10
192.168.0.14
192.168.0.4
---------------------
```

### nmap-parser.sh -parsip
```
192.168.0.1 [1900, 49152, 53, 80, ]
192.168.0.10 [443, 902, 912, ]
```


### nmap-parser.sh -uports
```
1900,443,49152,53,80,902,912
```
