# Ultimate Nmap Parser 

**VERSION 0.5**



This is still in BETA - mileage may vary

So i rewrote the old script that was taking this sport.

This is aimed at being the only script you need to parse .gnmap files to use with other tools such as Nessus, Nikto, SSLScan, Enum4Linux etc...
This will build up and improve overtime with new features as I require it.


My first scrip released on github (:




## Features
* Parse out IP addresses of hosts that are Up/Down
* Generate .csv file
* Generate a summary of open ports 
* Parse out TCP,UDP and Unqiue ports
* Generate URL list from open web ports
* Generate a list of IP addresses 
* Parse out a list of IP:PORT
* Create indidivual files for IPs of open ports



## Installation

Clone the git and pretty much it 

```
git clone https://github.com/Shifty0g/ultimate-nmap-parser/
cd ultimate-nmap-parser/
chmod +x ultimate-nmap-parser.sh
./ultimate-nmap-parser.sh
```



# Usage

```
# ./ultimate-nmap-parser.sh [input] [options]

```

## Example

```
# ./ultimate-nmap-parser.sh --help
-----------------------------------------------------------------------------------------------------------

               █    ██  ██▓  ▄▄▄█████▓ ██▓ ███▄ ▄███▓ ▄▄▄     ▄▄▄█████▓▓█████                                   
               ██  ▓██▒▓██▒  ▓  ██▒ ▓▒▓██▒▓██▒▀█▀ ██▒▒████▄   ▓  ██▒ ▓▒▓█   ▀                                   
              ▓██  ▒██░▒██░  ▒ ▓██░ ▒░▒██▒▓██    ▓██░▒██  ▀█▄ ▒ ▓██░ ▒░▒███                                     
              ▓▓█  ░██░▒██░  ░ ▓██▓ ░ ░██░▒██    ▒██ ░██▄▄▄▄██░ ▓██▓ ░ ▒▓█  ▄                                   
              ▒▒█████▓ ░██████▒▒██▒ ░ ░██░▒██▒   ░██▒ ▓█   ▓██▒ ▒██▒ ░ ░▒████▒                                  
              ░▒▓▒ ▒ ▒ ░ ▒░▓  ░▒ ░░   ░▓  ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒ ░░   ░░ ▒░ ░                                  
              ░░▒░ ░ ░ ░ ░ ▒  ░  ░     ▒ ░░  ░      ░  ▒   ▒▒ ░   ░     ░ ░  ░                                  
               ░░░ ░ ░   ░ ░   ░       ▒ ░░      ░     ░   ▒    ░         ░                                     
                 ░         ░  ░        ░         ░         ░  ░           ░  ░                                  
                                                                                                   
  ███▄    █  ███▄ ▄███▓ ▄▄▄       ██▓███         ██▓███   ▄▄▄       ██▀███    ██████ ▓█████  ██▀███   
  ██ ▀█   █ ▓██▒▀█▀ ██▒▒████▄    ▓██░  ██▒      ▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒ 
 ▓██  ▀█ ██▒▓██    ▓██░▒██  ▀█▄  ▓██░ ██▓▒      ▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄   ▒███   ▓██ ░▄█ ▒ 
 ▓██▒  ▐▌██▒▒██    ▒██ ░██▄▄▄▄██ ▒██▄█▓▒ ▒      ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒▒▓█  ▄ ▒██▀▀█▄   
 ▒██░   ▓██░▒██▒   ░██▒ ▓█   ▓██▒▒██▒ ░  ░      ▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒░▒████▒░██▓ ▒██▒ 
 ░ ▒░   ▒ ▒ ░ ▒░   ░  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░      ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░ 
 ░ ░░   ░ ▒░░  ░      ░  ▒   ▒▒ ░░▒ ░           ░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░ 
    ░   ░ ░ ░      ░     ░   ▒   ░░             ░░         ░   ▒     ░░   ░ ░  ░  ░     ░     ░░   ░  
          ░        ░         ░  ░                           ░  ░   ░           ░     ░  ░   ░      

Version: 0.5 - 04/04/2019 	Created By: Shifty0g 	https://github.com/shifty0g  	
-----------------------------------------------------------------------------------------------------------

[*] Usage: ultimate-nmap-parser.sh [input] [options]

[input]:		Grepable nmap file(s) .gnmap - can have multiple

[options]:

	--help		Show this help menu
	--all		Runs ALL options - EXCLUDING: report1
	--csv		Create .csv file - parsed_nmap.csv
	--summary	Create host Summary report - summary.txt
	--closed	Create Summary of hosts with CLOSED ports - closed-summary.txt
  	--report1   	Report - IP[PORT1,PORT2,PORT3, ] - parsip.pl
	--unique	Parse open unique TCP & UDP ports - ports_unique.txt
	--tcp		Parse open TCP ports - ports_tcp.txt
	--udp		Parse open UDP ports - ports_udp.txt
	--up		Parse 'Up' hosts - hosts_up.txt
	--down		Parse 'Down' hosts - hosts_down.txt
	--ippport	Parse targets IP:PORT - parsed_ipport.txt
	--smb		Generate smb paths smb://IP - smb.txt
	--web		Generate web URLS http://IP:PORT https://IP:PORT  - web-urls.txt
	--ssl		Generate ssl/tls hosts list IP:PORT - ssl.txt
	--hostports	Generate hosts/hosts_<PORT>-<PROTOCOL>-<SERVICE>.txt files

[*] Example:

ultimate-nmap-parser.sh *.gnmap --all
ultimate-nmap-parser.sh nmap_tcp_full.gnmp nmap_udp_def.gnmap --summary --unique
ultimate-nmap-parser.sh nmap_tcp_full.gnmp nmap_udp_def.gnmap --web

-----------------------------------------------------------------------------------------------------------

```




