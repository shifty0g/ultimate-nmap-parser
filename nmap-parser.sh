#!/bin/bash
# my first script which go out of hand
# nmap parser functions 
VERSION="0.6" #20-04-16
# A collectiong of functions that parse nmap output degined to help and be useful to a pentester
# currently works best parsing lazymap output
# 
#
#
#
# UPhosts - this will out put the UP hosts from a ping scan
function UPhosts() {  
cat $nmapfile  2>/dev/null | grep "Up" | awk '{print $2}' | grep -v "Nmap" | sort --unique
}
#
#
#
# DOWNhosts - this will out put the Down hosts from a ping scan
function DOWNhosts() {
cat $nmapfile  2>/dev/null | grep  "Down" |awk '{print $2}' | grep -v "Nmap" | sort --unique
}
#
#
#
#
#uniqeports - will print out the unique TCP and UDP ports form all xml files in dir
function uniqeports() {
cat $nmapfile | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique | paste -s -d, 2>&1
}
#
#
#
#
# ipandport - this will make a list of hosts with open ports IP:PORT
function ipandport() {
# NEED TO CHECK MAKE SURE THIS IS PERFRECT
  for file in $(echo $nmapfile); do # will go through each .nmap file
            #echo $nmapfile
    for host in $(cat "$file" | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do # will go through each host
        for port in $(cat "$file" | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
        echo "$host:$port" >> ipnport
        done # end ports loop
     done # end hosts loop
   done
   cat ipnport | sort --unique
   rm ipnport
}
#
#
#
# iplist - will produce same output as nmap-parse.py
function iplist() {
  for file in $(echo $nmapfile); do # will go through each .nmap file
            #echo $nmapfile
    for host in $(cat "$file" | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do # will go through each host
        echo -n $host  "["
        for port in $(cat "$file" | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
        echo -n $port", "
        done # end ports loop
        echo  "]"
     done # end hosts loop
   done
}
#
#
# 
# allunique - print out unique pors, hosts and services
function allunique () {
#
echo "Unique hosts list"
echo "---------------------"
UPhosts
echo ""
echo "Unique open port list"
echo "---------------------"
uniqeports
echo ""
echo "Unique services list"
echo "---------------------"
cat $nmapfile| grep -o -P '/open/.{20}' | cut -d /  -f 5 | sort --unique| paste -s -d", " 2>&1
}
#
#
#
# stats - print out stat report of file
function stats () {  # not working!
echo "File used: "$nmapfile
echo "---------------------"
echo -e "\e[00;32m\033[1mHosts Up           : " $(UPhosts | wc -l)
echo -e "\e[00;31m\033[1mHosts Down         : " $(DOWNhosts | wc -l)
echo -e "\e[00mTotal Hosts        : " $(DOWNhosts | wc -l)+$(UPhosts | wc -l)
echo -e "\e[00m----------------------" #clear colour
    #cat *.gnmap | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | paste -s -d"\n" 2>&1
    #cat *.gnmap | grep -o -P '/open/.{20}' | cut -d /  -f 5 | paste -s -d"\n" 2>&1
echo -e "\e[00mTotal Open Ports on Live Hosts: " 
echo -e "\e[00m---------------------" #clear colour
portlist=$(uniqeports | tr ',' '\n')
uniqeports
echo -e "\e[00m---------------------" #clear colour
for check in $(echo $portlist); do # go through ports
echo $portlist | grep -o $check  | wc -l | grep ":"
         count=$(echo $portlist | grep -o $check  | wc -l )
         printf "%5s:%5s\n" "$check" "$count"
 done # end ports loop
echo -e "\e[00m---------------------" #clear colour
}
#
#
#
# simple report from .gnmap
function report () {
#
#
# closed, open|filterd and filtered not shown
cat $nmapfile | grep -v ^# | sed 's/Ports: /\'$'\n/g' | tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | sed 's/Ignored State.$//'  | grep -v "Status: Down" | sed '/^$/d;s/[[:blank:]]/  /g' | grep -v "open|filtered" | grep -v "filtered" #>> reportfile
}
#
#

function report2() {
  #for file in $(echo $nmapfile); do # will go through each .gnmap file
    for host in $(cat $nmapfile | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do #each host
        echo "----------"
        echo $host:
        echo "----------"
        for port in $(cat $nmapfile | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
        echo $port
        done # end ports loop
     done # end hosts loop
   #done
}


function report3 () {
  for host in $(cat $nmapfile | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do # will go through each host
         for port in $(cat $nmapfile | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
                   status=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f2 | sort --uniqu)
                   type=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f3 | sort --uniqu)
                   proto=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f5 | sort --uniqu) 
                   srv=$(cat $nmapfile | grep -w $host | grep -o -P $port.* | cut -d, -f1 | cut -d/ -f7 | sort --uniqu)
                   echo $host":"$port":"$proto":"$srv | uniq | grep -v Nmap | grep : >> ipandportlist
                   #port_$port 2> /dev/null  
                   echo $host":"$type":"$port":"$proto":"$status":"$srv                  
          done # end ports loop
    done # end hosts loop
}



#       
#
# pingreport = list up and down hosts
function pingreport( ) {
echo "File: "$nmapfile
echo ""
echo -e "\e[00;31m\033[1m["$(DOWNhosts | wc -l)"]Dead Hosts:\e[00m"
echo -e "\e[00;31m---------------------"
DOWNhosts
echo -e "\e[00;31m---------------------\e[00m"
echo -e "\e[00;32m\033[1m["$(UPhosts | wc -l)"]Alive Hosts:\e[00m" # alive hosts last better viewing if big targets list
echo -e "\e[00;32m---------------------"
UPhosts
echo -e "\e[00;32m---------------------\e[00m"
echo -e "\e[00m" # clear colours
}
#
#
#
# help - help options
function help () {
clear # because you have to have some ascii
echo -e "\e[34m ███╗   ██╗███╗   ███╗ █████╗ ██████╗       ██████╗  █████╗ ██████╗ ███████╗███████╗██████╗ "
echo -e "\e[34m ████╗  ██║████╗ ████║██╔══██╗██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗"
echo -e "\e[34m ██╔██╗ ██║██╔████╔██║███████║██████╔╝█████╗██████╔╝███████║██████╔╝███████╗█████╗  ██████╔╝"
echo -e "\e[34m ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ ╚════╝██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══╝  ██╔══██╗"
echo -e "\e[34m ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║           ██║     ██║  ██║██║  ██║███████║███████╗██║  ██║"
echo -e "\e[34m ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"                                                                                        
echo ""
echo -e "\e[91mVersion: "$VERSION
echo -e "\e[92m---------------------------------------------------------------------------------------------" 
echo -e "\e[36m "
echo -e "\e[1mUsage: ./nmap-parser.sh [options] [gnmap file] \e[0m\e[36m"
echo "  Run inside nmap output dir it will pickup *.gnamp"
echo "  If no file is specificed the script will look for *.gnmap in pwd"
echo -e "\e[34m "
echo -e "\e[1mOptions: \e[0m\e[34m "
echo "  -help       Show this help message and exit" #done
echo "  -uphosts    List live hosts from an nmap PingScan" #done
echo "  -dnhosts    List dead hosts from an nmap PingScan" #done
echo "  -preport    Ping report from PingScan" # still working on
echo "  -report     Cleaned up report live hosts with open ports from nmap TCP and UDP" # needs work
echo "  -report2    Another report just looks different"
echo "  -report3    Another third report"
echo "  -au         Will list all uniqe hosts, ports and services that are alive and open"
echo "  -uports     Will list unique open ports from nmap TCP and UDP good to feed into Nessus"
echo "  -iplist     Will produce same outpout as nmap-parse"  #done
echo "  -parsip     Will parse out a list of live IPS - parsip.pl" #needs fixing replication and showing hosts with nothing tidying
echo "  -ipreport   List of alive ip and open port which can be piped into other tools, IP:PORT" #done
echo "  -stats      Will produce a little stat report, total open ports est." # needs fixing and tidying
echo ""
echo -e "\e[92m---------------------------------------------------------------------------------------------" 
echo -e "\e[00m " # clear colours
# FROM OLD nmap-parser
#  -p PORTS, --port=PORTS
#                        Optional port filter argument e.g. 80 or 80,443
#  -e CMD, --exec=CMD    Script or tool to run on each IP remaining after port
#                        filter is applied. IP will be appended to end of
#                        script command line
#  -i, --iplist          Also print plain list of matching IPs
}
#
#
#
# MAIN HERE
if [ -z $2 ]
then
  #echo "***No file specified by user**"
  # will auto pick up file
  nmapfile=$(ls | grep '.gnmap')
  if [ -z "$nmapfile" ]
  then
  echo "cant find any file to use (*.gnmap)"
  fi
  launchargs=$1
elif [ -n $2 ]
then 
 nmapfile=$(echo $* | cut -d" "  -f2-) # take in file given by user
 launchargs=$1
fi

echo ""
echo "options   : "$nmapfile
echo "args      : "$launchargs
echo "---------------------"
#read -p "Press enter to continue"
clear
#
case $launchargs in
   "-uphosts") UPhosts;;
   "-dnhosts") DOWNhosts;;
   "-uports") uniqeports;;
   "-preport") pingreport;;
   "-report") report;;
   "-report2") report2;;
   "-report3") report3;;
   "-au") allunique;;
   "-iplist") ipandport |  cut -d:  -f 1 | sort --unique;;
   "-ipreport") ipandport;;
   "-parsip") iplist;;
   "-stats") stats;;        
   "-help") help;;
   *) help 
     echo "**No options provided!**"  ;;
esac

#
#
#
#
export -f report
export -f report2
export -f report3
export -f ipandport
export -f UPhosts
export -f DOWNhosts
export -f report
export -f stats
export -f pingreport
export -f iplist
export -f allunique
export file
export nmapfile
