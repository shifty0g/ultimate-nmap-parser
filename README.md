
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

