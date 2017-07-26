#!/bin/bash
# my first script which go out of hand
# nmap parser functions
VERSION="0.9" #26-07-17
# A collectiong of functions that parse nmap output degined to help and be useful to a pentester. works with *.gnmap files
#
#
#
#
# UPhosts - this will out put the UP hosts from a ping scan
function UPhosts() {
cat $nmapfile  2>/dev/null | grep "Up" | awk '{print $2}' | grep -v "Nmap" | sort --unique
}
#
# DOWNhosts - this will out put the Down hosts from a ping scan
function DOWNhosts() {
cat $nmapfile  2>/dev/null | grep  "Down" |awk '{print $2}' | grep -v "Nmap" | sort --unique
}
#
# uniqeports - will print out the unique TCP and UDP ports form all xml files in dir
function uniqeports() {
cat $nmapfile | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique | paste -s -d, 2>&1
}
#
# uniqueservices - prints the unqie ope port services found 
function uniqeservices() {
cat $nmapfile| grep -o -P '/open/.{20}' | cut -d /  -f 5 | sort --unique| paste -s -d", " 2>&1
}
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
# parsip - will produce same output as nmap-parse.py
function parsip() {
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
# simple report from .gnmap
function report () {
#
#
# closed, open|filterd and filtered not shown
r=$(cat "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' | tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')
echo -e "$r"
# older code used
#cat $nmapfile | grep -v ^# | sed 's/Ports: /\'$'\n/g' | tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | sed 's/Ignored State.$//'  | grep -v "Status: Down" | sed '/^$/d;s/[[:blank:]]/  /g' | grep -v "open|filtered" | grep -v "filtered" #>> reportfile
}
#
#


function rep1() {
# hard coded and dirty to pick
cat nmap*.gnmap >> allports

for host in $(cat allports | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do # will go through each host
        for port in $(cat allports | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
                status=$(cat allports | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f2 | sort --uniqu)
                type=$(cat allports | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f3 | sort --uniqu)
                proto=$(cat allports | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f5 | sort --uniqu)
                srv=$(cat allports | grep -w $host | grep -o -P $port.* | cut -d, -f1 | cut -d/ -f7 | sort --uniqu)
                echo $host":"$port":"$type":"$proto":"$status":"$srv | uniq | grep -v Nmap | grep : >> ipandportlist
                #port_$port 2> /dev/null
                echo $host":"$port":"$type":"$proto":"$status":"$srv
        done # end ports loop
        echo ""
    done # end hosts loop
    
    
    
# clean up
rm ipandportlist
rm allports

# end
}
#
#
#
#
#
#
function report2 () {
for host in $(cat $nmapfile | grep "Host:" | grep "open" | awk '{ print $2}'| sort --unique); do # will go through each host
        for port in $(cat $nmapfile | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
                status=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f2 | sort --uniqu)
                type=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f3 | sort --uniqu)
                proto=$(cat $nmapfile | grep -w $host | grep -o -P $port.{30} | cut -d , -f1 | cut -d / -f5 | sort --uniqu)
                srv=$(cat $nmapfile | grep -w $host | grep -o -P $port.* | cut -d, -f1 | cut -d/ -f7 | sort --uniqu)
                echo $host":"$port":"$type":"$proto":"$status":"$srv | uniq | grep -v Nmap | grep : >> ipandportlist
                #port_$port 2> /dev/null
                echo $host":"$port":"$type":"$proto":"$status":"$srv
        done # end ports loop
    done # end hosts loop
rm ipandportlist
}
# this will be report with extra options
function report4 () {

ip=""
port=""
proto=""
addressonly=""
while getopts "i:p:P:s:a" OPT; do
    case $OPT in
        i) ip=$OPTARG;;
        p) port=$OPTARG;;
        s) service=$OPTARG;;
        P) proto=$OPTARG;;
        a) addressonly=true;;
    esac
done
echo "star -"$*
echo "0 -"$0
echo "1 -"$1
echo "2 -" $2
echo "3 - "$3
echo "nmapfile - "$nmapfile
echo "ip - " $ip
echo "port - "$port
echo "proto - "$proto
echo "add only - "$addressonly


if [[ ! -z $ip ]]; then # search by IP
    r=$(grep -w "$ip" "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')

elif [[ ! -z $port ]]; then # search by port number
    r=$(grep -w -E -e "($port)\/open" "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | grep -E -e "Host: " -e "^(${port})" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')

elif [[ ! -z $service ]]; then # search by service name
    r=$(grep -w -E -i -e "($service)" "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | grep -i -E -e "Host: " -e "(${service})" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')
elif [[ ! -z $proto ]]; then
    r=$(grep -w -E -i -e "($proto)" "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | grep -i -E -e "Host: " -e "(${proto})" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')
else
    r=$(cat "$nmapfile" | grep -v ^# | sed 's/Ports: /\'$'\n/g' | tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Status: Up" | sed 's/Host:/\\033[0;32mHost:\\033[0;39m/g' | sed 's/Ignored State.*$//')
fi

if [[ $addressonly ]]; then # output only IPs/hostnames
    echo -e "$r" | grep "Host:" | awk {'print $2'}
else
    echo -e "$r"
fi
}

#
#
#
# stats - print out stat report of file
function stats () {
echo "File: "$nmapfile
echo ""
echo -e "\e[1m\e[93mTotal Hosts Scanned: " $(($(DOWNhosts | wc -l)+$(UPhosts | wc -l)))
echo ""
echo -e "\e[00;32m\033[1mAlive Hosts:" $(UPhosts | wc -l) # alive hosts last better viewing if big targets list
echo -e "\e[00;32m\033[1m---------------------"
UPhosts
echo -e "\e[00;32m\033[1m---------------------\e[00m"
echo ""
echo -e "\e[00;31m\033[1mDead Hosts:    $(DOWNhosts | wc -l)"
echo -e "\e[00;31m\033[1m---------------------"
DOWNhosts
echo -e "\e[00;31m\033[1m---------------------"
portlist=$(cat $nmapfile | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | paste -s -d, 2>&1 | tr ',' '\n')
echo -e "\e[01m\e[00m"


echo "Total Open ports: " $(cat $nmapfile | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | paste -s -d, 2>&1 | tr ',' '\n\r' |  wc -l)
echo -e "---------------------" #clear colour
for check in $(echo $portlist); do # go through ports
totalports=0
echo $portlist | grep -o $check  | wc -l | grep ":"
        count=$(echo $portlist | grep -o $check  | wc -l )
        printf "%5s : $count \n" "$check" >> port22
done # end ports loop
cat port22 | cut -d :  -f 2 | cut -d' '  -f2



cat port22
rm port22

echo -e "\e[00m---------------------" #clear colour
echo ""
echo -e "\e[01m\e[95mUnique Ports: " $(uniqeports | tr ',' '\n\r' | wc -l)
echo -e "---------------------" #clear colour
uniqeports
echo -e "---------------------" #clear colour
echo -e "\e[01;94m "
echo "Unique Services:"
echo "---------------------"
uniqeservices
}

#
#
#
# help - help options
function help () {
#clear # because you have to have some ascii
echo ""
echo ""
echo -e "\e[34m ███╗   ██╗███╗   ███╗ █████╗ ██████╗       ██████╗  █████╗ ██████╗ ███████╗███████╗██████╗ "
echo -e "\e[31m ████╗  ██║████╗ ████║██╔══██╗██╔══██╗      ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗"
echo -e "\e[32m ██╔██╗ ██║██╔████╔██║███████║██████╔╝█████╗██████╔╝███████║██████╔╝███████╗█████╗  ██████╔╝"
echo -e "\e[33m ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ ╚════╝██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══╝  ██╔══██╗"
echo -e "\e[34m ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║           ██║     ██║  ██║██║  ██║███████║███████╗██║  ██║"
echo -e "\e[35m ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"
echo ""
echo -e "\e[91mVersion: "$VERSION
echo -e "\e[92m---------------------------------------------------------------------------------------------"
echo -e "\e[36m "
echo -e "\e[1mUsage: 
    ./nmap-parser.sh -f [gnmap file] [options] \e[0m\e[36m"
echo -e "\e[94m "
echo -e "\e[1mOptions: \e[0m\e[94m "
echo "  -h    Show this help message and exit" #done
echo "  -u    IP - List up hosts - ping" #done
echo "  -d    IP - List down hosts - ping" #done
echo "  -p    PORT1,PORT2,PORT3,.. - List Unique open ports "
echo "  -v    SERVICE1,SERVICE2,SERVICE3,.. - List Unique services for open ports" #
echo "  -s    Stats - Numbers on open ports, alive hosts est" # needs fixing and tidying
echo "  -ir   IP:PORT - List alive hosts and ports (useful to pipe into other tools)" #done
echo "  -r    IP:PORT:PROTOCOL:STATUS:SERVICE - List alive hosts, ports and ports" 
echo "  -r1   Report - Basic clean report"
echo "  -r2   Report - IP[PORT1,PORT2, ] - parsip.pl" #needs fixing replication and showing hosts with nothing tidying
echo "  -r3   Report **TESTING**" #needs fixing replication and showing hosts with nothing tidying
#nmap-parser null null -rep1  = secret command for me . need to implament further
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

nmapfile=$2
launchargs=$3

case $launchargs in
"-u") UPhosts;;
"-d") DOWNhosts;;
"-p") uniqeports;;
"-r1") report;;
"-r") report2;;
"-v") uniqeservices;;
"-r2") report4;;
"-r3") parsip;;
"-au") allunique;;
"-ir") ipandport;;
"-s") stats;;
"-h") help;;
"-rep1") rep1;;
*) help
    echo "**No options provided!**"  ;;
esac

#
#
#
#
export -f report4
export -f report
export -f report2
export -f UPhosts
export -f DOWNhosts
export -f report
export -f stats
export -f ipandport
export -f uniqeservices
export -f rep1
export file
export nmapfile
#
