# Ultimate Nmap Parser 

**Date: 08/06/2019**

**VERSION 0.6**


This is still in **BETA** - mileage may vary. Please let me know if you have any issues/bugs as im keen to have this fully working and will improve it overtime and add features

So i rewrote the old script that was taking this sport.

The only script you will need to parse **.gnmap** files. The output can be used with other tools such as Nessus, Nikto, SSLScan, Enum4Linux etc...

My first script released on github (:



## Features
* Parse out IP addresses of hosts that are Up/Down
* Generate .csv file
* Generate a summary report of open ports 
* Parse out TCP,UDP and Unqiue ports
* Generate URL list from open web ports - https://192.168.2.11:443
* Generate a list of SMB connections - SMB://X.X.X.X
* Generate a list of SSL ports.
* Parse out a list of IP:PORT - 192.168.2.11:443
* Create indidivual files for IPs of open ports to be used with other tools



## Installation

Clone the git and you pretty much ready to roll

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

## Example Output 

### ./ultimate-nmap-parser.sh *.gnmap --all

[![asciicast](https://asciinema.org/a/OuQNlH1fnO0TBTNmQFQwW0a9z.svg)](https://asciinema.org/a/OuQNlH1fnO0TBTNmQFQwW0a9z)

### ./ultimate-nmap-parser.sh --help
```
	_  _ _    ___ _ _  _ ____ ___ ____    _  _ _  _ ____ ___  
	|  | |     |  | |\/| |__|  |  |___    |\ | |\/| |__| |__] 
	|__| |___  |  | |  | |  |  |  |___    | \| |  | |  | |    
			___  ____ ____ ____ ____ ____                   
			|__] |__| |__/ [__  |___ |__/                   
			|    |  | |  \ ___] |___ |  \                   
			                                                
Version: 0.6 - 08/06/2019
Created By: Shifty0g 	https://github.com/shifty0g  


[*] Usage: ultimate-nmap-parser.sh [input] [options]

[input]:		Grepable nmap file(s) .gnmap - can have multiple

[options]:

	--help		Show this help menu
	--all		Runs ALL options - **EXCLUDING: report1, --html**
	--csv		Create .csv file - parsed_nmap.csv
	--summary	Create host Summary report - summary.txt
	--closed	Create Summary of hosts with CLOSED ports - closed-summary.txt
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
  	--report1   	Report - IP[PORT1,PORT2,PORT3, ] - parsip.pl

[*] Example:

ultimate-nmap-parser.sh *.gnmap --all
ultimate-nmap-parser.sh nmap_tcp_full.gnmp nmap_udp_def.gnmap --summary --unique
ultimate-nmap-parser.sh nmap_tcp_full.gnmp nmap_udp_def.gnmap --web

--------------------------------------------------------------------------------------



```

### ./ultimate-nmap-parser.sh *.gnmap --csv

```
HOST,PORT,STATUS,PROTOCOL,SERVICE,VERSION
10.10.10.101,22,open,tcp,ssh,OpenSSH 7.6p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
10.10.10.101,80,open,tcp,http,Apache httpd 2.4.29 ((Ubuntu))
10.10.10.101,2222,open,tcp,ssh,OpenSSH 7.6p1 Ubuntu 4ubuntu0.2 (Ubuntu Linux; protocol 2.0)
10.10.10.101,8080,open,tcp,http,Apache Tomcat|Coyote JSP engine 1.1
10.10.10.103,21,open,tcp,ftp,Microsoft ftpd
10.10.10.103,53,open,tcp,domain?,
10.10.10.103,80,open,tcp,http,Microsoft IIS httpd 10.0
10.10.10.103,123,open,udp,ntp,
10.10.10.103,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.103,139,open,tcp,netbios-ssn,Microsoft Windows netbios-ssn
10.10.10.103,389,open,tcp,ldap,Microsoft Windows Active Directory LDAP (Domain: HTB.LOCAL
10.10.10.103,443,open,tcp,ssl|http,Microsoft IIS httpd 10.0
10.10.10.103,445,open,tcp,microsoft-ds?,
10.10.10.103,464,open,tcp,kpasswd5?,
10.10.10.103,593,open,tcp,ncacn_http,Microsoft Windows RPC over HTTP 1.0
10.10.10.103,636,open,tcp,ssl|ldap,Microsoft Windows Active Directory LDAP (Domain: HTB.LOCAL
10.10.10.103,3268,open,tcp,ldap,Microsoft Windows Active Directory LDAP (Domain: HTB.LOCAL
10.10.10.103,3269,open,tcp,ssl|ldap,Microsoft Windows Active Directory LDAP (Domain: HTB.LOCAL
10.10.10.103,49153,open,udp,unknown,
10.10.10.103,49200,open,udp,unknown,
10.10.10.116,500,open,udp,isakmp,
10.10.10.119,22,open,tcp,ssh,OpenSSH 7.4 (protocol 2.0)
10.10.10.119,80,open,tcp,http,Apache httpd 2.4.6 ((CentOS) OpenSSL|1.0.2k-fips mod_fcgid|2.3.9 PHP|5.4.16)
10.10.10.119,389,open,tcp,ldap,OpenLDAP 2.2.X - 2.3.X
10.10.10.120,80,open,tcp,http,Apache httpd 2.4.34 ((Ubuntu))
10.10.10.120,110,open,tcp,pop3,Dovecot pop3d
10.10.10.120,143,open,tcp,imap,Dovecot imapd (Ubuntu)
10.10.10.120,993,open,tcp,ssl|imap,Dovecot imapd (Ubuntu)
10.10.10.120,995,open,tcp,ssl|pop3,
10.10.10.120,10000,open,tcp,http,MiniServ 1.890 (Webmin httpd)
10.10.10.120,10000,open,udp,ndmp,
10.10.10.121,22,open,tcp,ssh,OpenSSH 7.2p2 Ubuntu 4ubuntu2.6 (Ubuntu Linux; protocol 2.0)
10.10.10.121,80,open,tcp,http,Apache httpd 2.4.18 ((Ubuntu))
10.10.10.121,3000,open,tcp,http,Node.js Express framework
10.10.10.122,22,open,tcp,ssh,OpenSSH 7.4 (protocol 2.0)
10.10.10.122,80,open,tcp,http,Apache httpd 2.4.6 ((CentOS) OpenSSL|1.0.2k-fips mod_fcgid|2.3.9 PHP|5.4.16)
10.10.10.123,21,open,tcp,ftp,vsftpd 3.0.3
10.10.10.123,22,open,tcp,ssh,OpenSSH 7.6p1 Ubuntu 4 (Ubuntu Linux; protocol 2.0)
10.10.10.123,53,open,tcp,domain,ISC BIND 9.11.3-1ubuntu1.2 (Ubuntu Linux)
10.10.10.123,53,open,udp,domain,
10.10.10.123,80,open,tcp,http,Apache httpd 2.4.29 ((Ubuntu))
10.10.10.123,137,open,udp,netbios-ns,
10.10.10.123,139,open,tcp,netbios-ssn,Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
10.10.10.123,443,open,tcp,ssl|http,Apache httpd 2.4.29
10.10.10.123,445,open,tcp,netbios-ssn,Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
10.10.10.124,22,open,tcp,ssh?,
10.10.10.124,80,open,tcp,http,ClownWare Proxy
10.10.10.124,443,open,tcp,tcpwrapped,
10.10.10.124,8080,open,tcp,tcpwrapped,
10.10.10.125,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.125,139,open,tcp,netbios-ssn,Microsoft Windows netbios-ssn
10.10.10.125,445,open,tcp,microsoft-ds?,
10.10.10.125,1433,open,tcp,ms-sql-s,Microsoft SQL Server vNext tech preview 14.00.1000
10.10.10.126,80,open,tcp,http,nginx 1.10.3
10.10.10.126,443,open,tcp,ssl|http,nginx 1.10.3
10.10.10.127,22,open,tcp,ssh,OpenSSH 7.9 (protocol 2.0)
10.10.10.127,80,open,tcp,http,OpenBSD httpd
10.10.10.127,443,open,tcp,ssl|https?,
10.10.10.128,80,open,tcp,http,Microsoft IIS httpd 10.0
10.10.10.128,6666,open,tcp,http,Microsoft HTTPAPI httpd 2.0 (SSDP|UPnP)
10.10.10.129,22,open,tcp,ssh,OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
10.10.10.129,80,open,tcp,http,Apache httpd 2.4.29 ((Ubuntu))
10.10.10.130,80,open,tcp,http,Microsoft IIS httpd 10.0
10.10.10.130,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.130,139,open,tcp,netbios-ssn,Microsoft Windows netbios-ssn
10.10.10.130,445,open,tcp,microsoft-ds?,
10.10.10.130,8080,open,tcp,http,Apache Tomcat 8.5.37
10.10.10.131,21,open,tcp,ftp,vsftpd 2.3.4
10.10.10.131,22,open,tcp,ssh,OpenSSH 7.9 (protocol 2.0)
10.10.10.131,80,open,tcp,http,Node.js (Express middleware)
10.10.10.131,443,open,tcp,ssl|http,Node.js Express framework
10.10.10.132,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.132,445,open,tcp,microsoft-ds?,
10.10.10.132,8080,open,tcp,http-proxy,-
10.10.10.133,22,open,tcp,ssh,OpenSSH 7.4p1 Debian 10+deb9u6 (protocol 2.0)
10.10.10.133,80,open,tcp,http,Apache httpd 2.4.25 ((Debian))
10.10.10.134,22,open,tcp,ssh,OpenSSH for_Windows_7.9 (protocol 2.0)
10.10.10.134,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.134,139,open,tcp,netbios-ssn,Microsoft Windows netbios-ssn
10.10.10.134,445,open,tcp,microsoft-ds,Microsoft Windows Server 2008 R2 - 2012 microsoft-ds
10.10.10.152,21,open,tcp,ftp,Microsoft ftpd
10.10.10.152,80,open,tcp,http,Indy httpd 18.1.37.13946 (Paessler PRTG bandwidth monitor)
10.10.10.152,135,open,tcp,msrpc,Microsoft Windows RPC
10.10.10.152,139,open,tcp,netbios-ssn,Microsoft Windows netbios-ssn
10.10.10.152,445,open,tcp,microsoft-ds,Microsoft Windows Server 2008 R2 - 2012 microsoft-ds

```

### ./ultimate-nmap-parser.sh *.gnmap --summary

```
+=========================================================================================+
| HOST             | PORT / PROTOCOL  | SERVICE                                           |  
+=========================================================================================+
| 10.10.10.101     | 22 / tcp         | ssh - OpenSSH 7.6p1 Ubuntu 4ubuntu0.1 (Ubuntu Li  | 
| 10.10.10.101     | 80 / tcp         | http - Apache httpd 2.4.29 ((Ubuntu))             | 
| 10.10.10.101     | 2222 / tcp       | ssh - OpenSSH 7.6p1 Ubuntu 4ubuntu0.2 (Ubuntu Li  | 
| 10.10.10.101     | 8080 / tcp       | http - Apache Tomcat|Coyote JSP engine 1.1        | 
+=========================================================================================+
| 10.10.10.103     | 21 / tcp         | ftp - Microsoft ftpd                              | 
| 10.10.10.103     | 53 / tcp         | domain?                                           | 
| 10.10.10.103     | 80 / tcp         | http - Microsoft IIS httpd 10.0                   | 
| 10.10.10.103     | 123 / udp        | ntp                                               | 
| 10.10.10.103     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.103     | 139 / tcp        | netbios-ssn - Microsoft Windows netbios-ssn       | 
| 10.10.10.103     | 389 / tcp        | ldap - Microsoft Windows Active Directory LDAP (  | 
| 10.10.10.103     | 443 / tcp        | ssl|http - Microsoft IIS httpd 10.0               | 
| 10.10.10.103     | 445 / tcp        | microsoft-ds?                                     | 
| 10.10.10.103     | 464 / tcp        | kpasswd5?                                         | 
| 10.10.10.103     | 593 / tcp        | ncacn_http - Microsoft Windows RPC over HTTP 1.0  | 
| 10.10.10.103     | 636 / tcp        | ssl|ldap - Microsoft Windows Active Directory LD  | 
| 10.10.10.103     | 3268 / tcp       | ldap - Microsoft Windows Active Directory LDAP (  | 
| 10.10.10.103     | 3269 / tcp       | ssl|ldap - Microsoft Windows Active Directory LD  | 
| 10.10.10.103     | 49153 / udp      | unknown                                           | 
| 10.10.10.103     | 49200 / udp      | unknown                                           | 
+=========================================================================================+
| 10.10.10.116     | 500 / udp        | isakmp                                            | 
+=========================================================================================+
| 10.10.10.119     | 22 / tcp         | ssh - OpenSSH 7.4 (protocol 2.0)                  | 
| 10.10.10.119     | 80 / tcp         | http - Apache httpd 2.4.6 ((CentOS) OpenSSL|1.0.  | 
| 10.10.10.119     | 389 / tcp        | ldap - OpenLDAP 2.2.X - 2.3.X                     | 
+=========================================================================================+
| 10.10.10.120     | 80 / tcp         | http - Apache httpd 2.4.34 ((Ubuntu))             | 
| 10.10.10.120     | 110 / tcp        | pop3 - Dovecot pop3d                              | 
| 10.10.10.120     | 143 / tcp        | imap - Dovecot imapd (Ubuntu)                     | 
| 10.10.10.120     | 993 / tcp        | ssl|imap - Dovecot imapd (Ubuntu)                 | 
| 10.10.10.120     | 995 / tcp        | ssl|pop3                                          | 
| 10.10.10.120     | 10000 / tcp      | http - MiniServ 1.890 (Webmin httpd)              | 
| 10.10.10.120     | 10000 / udp      | ndmp                                              | 
+=========================================================================================+
| 10.10.10.121     | 22 / tcp         | ssh - OpenSSH 7.2p2 Ubuntu 4ubuntu2.6 (Ubuntu Li  | 
| 10.10.10.121     | 80 / tcp         | http - Apache httpd 2.4.18 ((Ubuntu))             | 
| 10.10.10.121     | 3000 / tcp       | http - Node.js Express framework                  | 
+=========================================================================================+
| 10.10.10.122     | 22 / tcp         | ssh - OpenSSH 7.4 (protocol 2.0)                  | 
| 10.10.10.122     | 80 / tcp         | http - Apache httpd 2.4.6 ((CentOS) OpenSSL|1.0.  | 
+=========================================================================================+
| 10.10.10.123     | 21 / tcp         | ftp - vsftpd 3.0.3                                | 
| 10.10.10.123     | 22 / tcp         | ssh - OpenSSH 7.6p1 Ubuntu 4 (Ubuntu Linux; prot  | 
| 10.10.10.123     | 53 / tcp         | domain - ISC BIND 9.11.3-1ubuntu1.2 (Ubuntu Linu  | 
| 10.10.10.123     | 53 / udp         | domain                                            | 
| 10.10.10.123     | 80 / tcp         | http - Apache httpd 2.4.29 ((Ubuntu))             | 
| 10.10.10.123     | 137 / udp        | netbios-ns                                        | 
| 10.10.10.123     | 139 / tcp        | netbios-ssn - Samba smbd 3.X - 4.X (workgroup: W  | 
| 10.10.10.123     | 443 / tcp        | ssl|http - Apache httpd 2.4.29                    | 
| 10.10.10.123     | 445 / tcp        | netbios-ssn - Samba smbd 3.X - 4.X (workgroup: W  | 
+=========================================================================================+
| 10.10.10.124     | 22 / tcp         | ssh?                                              | 
| 10.10.10.124     | 80 / tcp         | http - ClownWare Proxy                            | 
| 10.10.10.124     | 443 / tcp        | tcpwrapped                                        | 
| 10.10.10.124     | 8080 / tcp       | tcpwrapped                                        | 
+=========================================================================================+
| 10.10.10.125     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.125     | 139 / tcp        | netbios-ssn - Microsoft Windows netbios-ssn       | 
| 10.10.10.125     | 445 / tcp        | microsoft-ds?                                     | 
| 10.10.10.125     | 1433 / tcp       | ms-sql-s - Microsoft SQL Server vNext tech previ  | 
+=========================================================================================+
| 10.10.10.126     | 80 / tcp         | http - nginx 1.10.3                               | 
| 10.10.10.126     | 443 / tcp        | ssl|http - nginx 1.10.3                           | 
+=========================================================================================+
| 10.10.10.127     | 22 / tcp         | ssh - OpenSSH 7.9 (protocol 2.0)                  | 
| 10.10.10.127     | 80 / tcp         | http - OpenBSD httpd                              | 
| 10.10.10.127     | 443 / tcp        | ssl|https?                                        | 
+=========================================================================================+
| 10.10.10.128     | 80 / tcp         | http - Microsoft IIS httpd 10.0                   | 
| 10.10.10.128     | 6666 / tcp       | http - Microsoft HTTPAPI httpd 2.0 (SSDP|UPnP)    | 
+=========================================================================================+
| 10.10.10.129     | 22 / tcp         | ssh - OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Li  | 
| 10.10.10.129     | 80 / tcp         | http - Apache httpd 2.4.29 ((Ubuntu))             | 
+=========================================================================================+
| 10.10.10.130     | 80 / tcp         | http - Microsoft IIS httpd 10.0                   | 
| 10.10.10.130     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.130     | 139 / tcp        | netbios-ssn - Microsoft Windows netbios-ssn       | 
| 10.10.10.130     | 445 / tcp        | microsoft-ds?                                     | 
| 10.10.10.130     | 8080 / tcp       | http - Apache Tomcat 8.5.37                       | 
+=========================================================================================+
| 10.10.10.131     | 21 / tcp         | ftp - vsftpd 2.3.4                                | 
| 10.10.10.131     | 22 / tcp         | ssh - OpenSSH 7.9 (protocol 2.0)                  | 
| 10.10.10.131     | 80 / tcp         | http - Node.js (Express middleware)               | 
| 10.10.10.131     | 443 / tcp        | ssl|http - Node.js Express framework              | 
+=========================================================================================+
| 10.10.10.132     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.132     | 445 / tcp        | microsoft-ds?                                     | 
| 10.10.10.132     | 8080 / tcp       | http-proxy - -                                    | 
+=========================================================================================+
| 10.10.10.133     | 22 / tcp         | ssh - OpenSSH 7.4p1 Debian 10+deb9u6 (protocol 2  | 
| 10.10.10.133     | 80 / tcp         | http - Apache httpd 2.4.25 ((Debian))             | 
+=========================================================================================+
| 10.10.10.134     | 22 / tcp         | ssh - OpenSSH for_Windows_7.9 (protocol 2.0)      | 
| 10.10.10.134     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.134     | 139 / tcp        | netbios-ssn - Microsoft Windows netbios-ssn       | 
| 10.10.10.134     | 445 / tcp        | microsoft-ds - Microsoft Windows Server 2008 R2   | 
+=========================================================================================+
| 10.10.10.152     | 21 / tcp         | ftp - Microsoft ftpd                              | 
| 10.10.10.152     | 80 / tcp         | http - Indy httpd 18.1.37.13946 (Paessler PRTG b  | 
| 10.10.10.152     | 135 / tcp        | msrpc - Microsoft Windows RPC                     | 
| 10.10.10.152     | 139 / tcp        | netbios-ssn - Microsoft Windows netbios-ssn       | 
| 10.10.10.152     | 445 / tcp        | microsoft-ds - Microsoft Windows Server 2008 R2   | 
+=========================================================================================+

```

### ./ultimate-nmap-parser.sh *.gnmap --ippport

```
10.10.10.101:22
10.10.10.101:80
10.10.10.101:2222
10.10.10.101:8080
10.10.10.103:21
10.10.10.103:53
10.10.10.103:80
10.10.10.103:123
10.10.10.103:135
10.10.10.103:139
10.10.10.103:389
10.10.10.103:443
10.10.10.103:445
10.10.10.103:464
10.10.10.103:593
10.10.10.103:636
10.10.10.103:3268
10.10.10.103:3269
10.10.10.103:49153
10.10.10.103:49200
10.10.10.116:500
10.10.10.119:22
10.10.10.119:80
10.10.10.119:389
10.10.10.120:80
10.10.10.120:110
10.10.10.120:143
10.10.10.120:993
10.10.10.120:995
10.10.10.120:10000
10.10.10.120:10000
10.10.10.121:22
10.10.10.121:80
10.10.10.121:3000
10.10.10.122:22
10.10.10.122:80
10.10.10.123:21
10.10.10.123:22
10.10.10.123:53
10.10.10.123:53
10.10.10.123:80
10.10.10.123:137
10.10.10.123:139
10.10.10.123:443
10.10.10.123:445
10.10.10.124:22
10.10.10.124:80
10.10.10.124:443
10.10.10.124:8080
10.10.10.125:135
10.10.10.125:139
10.10.10.125:445
10.10.10.125:1433
10.10.10.126:80
10.10.10.126:443
10.10.10.127:22
10.10.10.127:80
10.10.10.127:443
10.10.10.128:80
10.10.10.128:6666
10.10.10.129:22
10.10.10.129:80
10.10.10.130:80
10.10.10.130:135
10.10.10.130:139
10.10.10.130:445
10.10.10.130:8080
10.10.10.131:21
10.10.10.131:22
10.10.10.131:80
10.10.10.131:443
10.10.10.132:135
10.10.10.132:445
10.10.10.132:8080
10.10.10.133:22
10.10.10.133:80
10.10.10.134:22
10.10.10.134:135
10.10.10.134:139
10.10.10.134:445
10.10.10.152:21
10.10.10.152:80
10.10.10.152:135
10.10.10.152:139

```


### ./ultimate-nmap-parser.sh *.gnmap --unique

```
21,22,53,80,110,123,135,137,139,143,389,443,445,464,500,593,636,993,995,1433,2222,3000,3268,3269,6666,8080,10000,49153,49200
```


### ./ultimate-nmap-parser.sh *.gnmap --web

```
http://10.10.10.101:80/
http://10.10.10.101:8080/
http://10.10.10.103:80/
https://10.10.10.103:443/
https://10.10.10.103:636/
https://10.10.10.103:3269/
http://10.10.10.119:80/
http://10.10.10.120:80/
https://10.10.10.120:993/
https://10.10.10.120:995/
http://10.10.10.120:10000/
http://10.10.10.121:80/
http://10.10.10.121:3000/
http://10.10.10.122:80/
http://10.10.10.123:80/
https://10.10.10.123:443/
http://10.10.10.124:80/
https://10.10.10.124:443/
http://10.10.10.124:8080/
http://10.10.10.126:80/
https://10.10.10.126:443/
http://10.10.10.127:80/
https://10.10.10.127:443/
http://10.10.10.128:80/
http://10.10.10.128:6666/
http://10.10.10.129:80/
http://10.10.10.130:80/
http://10.10.10.130:8080/
http://10.10.10.131:80/
https://10.10.10.131:443/
http://10.10.10.132:8080/
http://10.10.10.133:80/
http://10.10.10.152:80/

```

### ./ultimate-nmap-parser.sh *.gnmap --web

```
smb://10.10.10.103
smb://10.10.10.123
smb://10.10.10.125
smb://10.10.10.130
smb://10.10.10.132
smb://10.10.10.134
smb://10.10.10.152
```



### ./ultimate-nmap-parser.sh *.gnmap --closed

```
Closed Ports For Host: 192.168.0.23 
	123, 1234, 49154, 49155, 49163, 5001, 6000, 6100, 80, 8081, 9080, 9998, 9999, 
 
Closed Ports For Host: 192.168.0.25 
	49154, 49163, 5001, 6000, 6100, 8081, 9080, 9998, 9999, 
```


### ./ultimate-nmap-parser.sh *.gnmap --hostports

```
ls  parse/hosts 
hosts_10000-tcp-http.txt      hosts_143-tcp-imap.txt      hosts_443-tcp-sslhttps.txt     hosts_500-udp-isakmp.txt      hosts_8080-tcp-tcpwrapped.txt
hosts_10000-udp-ndmp.txt      hosts_21-tcp-ftp.txt        hosts_443-tcp-sslhttp.txt      hosts_53-tcp-domain.txt       hosts_80-tcp-http.txt
hosts_110-tcp-pop3.txt        hosts_2222-tcp-ssh.txt      hosts_443-tcp-tcpwrapped.txt   hosts_53-udp-domain.txt       hosts_993-tcp-sslimap.txt
hosts_123-udp-ntp.txt         hosts_22-tcp-ssh.txt        hosts_445-tcp-microsoftds.txt  hosts_593-tcp-ncacn_http.txt  hosts_995-tcp-sslpop3.txt
hosts_135-tcp-msrpc.txt       hosts_3000-tcp-http.txt     hosts_445-tcp-netbiosssn.txt   hosts_636-tcp-sslldap.txt
hosts_137-udp-netbiosns.txt   hosts_3268-tcp-ldap.txt     hosts_464-tcp-kpasswd5.txt     hosts_6666-tcp-http.txt
hosts_139-tcp-netbiosssn.txt  hosts_3269-tcp-sslldap.txt  hosts_49153-udp-unknown.txt    hosts_8080-tcp-httpproxy.txt
hosts_1433-tcp-mssqls.txt     hosts_389-tcp-ldap.txt      hosts_49200-udp-unknown.txt    hosts_8080-tcp-http.txt

# cat parse/hosts/hosts_21-tcp-ftp.txt 
10.10.10.103
10.10.10.123
10.10.10.131
10.10.10.152

# cat parse/hosts/hosts_80-tcp-http.txt 
10.10.10.101
10.10.10.103
10.10.10.119
10.10.10.120
10.10.10.121
10.10.10.122
10.10.10.123
10.10.10.124
10.10.10.126
10.10.10.127
10.10.10.128
10.10.10.129
10.10.10.130
10.10.10.131
10.10.10.133
10.10.10.152

```
