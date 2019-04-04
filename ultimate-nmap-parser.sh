#!/bin/bash
fname="ultimate-nmap-parser.sh"
version="0.5"
modified="04/04/2019"


# TO DO:
#
# - better checks for Up/Down hosts
# - have a bit at the end to print the output of files
# - use less temp files try and keep things consistant in oneliner
# - tidy up the script make it organised
# - give the functions desicriptions so know what they are doing 
# - renames the hosts services for indvidual port file ftp,telnet,ssl,web,http/https/ssl,mysql,oracle,mssql,smb,snmp....est so they are a bit bteer 
# - create some error checking. file checks for each function. main file checks. fix the switches 
# - test every switch and options
# - stop reusing code. make functions for repeats
# - better input checks. all runs first - giant if statemnt to check switches are valid first
# - add useful features from OLD nmap-parser
# - change the if statements so that there is an all function so it will set all the varibles on and create the folder. this needs testing too 
# - TEST TEST TEST TEST TEST and check the output with lots of different scans and make sure it is all accurate. 
#







#----------------------------------------------------------------- START OF SCRIPT -----------------------------------------------------------------


# doesnt seem to work that well so used version sort seems to be the best
export sortip="sort -V"
#export sortip="sort -t. -n -k1 | sort -t. -n -k2 | sort -t. -n -k3 | sort -t. -n -k4 | sort -u -V"
#export sortip="sort -t. -k 1 -V | sort -t. -k 2 -V | sort -t. -k 3 -V | sort -t. -k 4 -V"


#output folder 
createoutdir="N"	#Turn ON if you always want kdir outdir
outdir="parse"
outhostsdir="hosts"


#output file names
outputcsvfile="parsed_nmap.csv"
outputsummaryfile="summary.txt"
outputclosedfile="closed-summary.txt"
outputipfile="parsed_ipport.txt"
outputupfile="hosts_up.txt"
outputdownfile="hosts_down.txt"
outputuniquefile="ports_unique.txt"
outputtcpfile="ports_tcp.txt"
outputudpfile="ports_udp.txt"
outputsmbfile="smb.txt"
outputwebfile="web-urls.txt"
outputsslfile="ssl.txt"
outputreport1file="report1.txt"
outputclosedsummaryfile="closed-summary.txt"



# Menu Switches
men_all="N"
men_csv="N"
men_summary="N"
men_uports="N"
men_tcpports="N"
men_udpports="N"
men_uphosts="N"
men_downhosts="N"
men_ipport="N"
men_smb="N"
men_ssl="N"
men_web="N"
men_hostports="N"
men_closed="N"
men_report1="N"




function header () {
# header function  - used to print out the title of the script 
# need a better name i think
echo "-----------------------------------------------------------------------------------------------------------"
echo -e "\e[91m\e[1m"
echo "               █    ██  ██▓  ▄▄▄█████▓ ██▓ ███▄ ▄███▓ ▄▄▄     ▄▄▄█████▓▓█████                                   "
echo "               ██  ▓██▒▓██▒  ▓  ██▒ ▓▒▓██▒▓██▒▀█▀ ██▒▒████▄   ▓  ██▒ ▓▒▓█   ▀                                   "
echo "              ▓██  ▒██░▒██░  ▒ ▓██░ ▒░▒██▒▓██    ▓██░▒██  ▀█▄ ▒ ▓██░ ▒░▒███                                     "
echo "              ▓▓█  ░██░▒██░  ░ ▓██▓ ░ ░██░▒██    ▒██ ░██▄▄▄▄██░ ▓██▓ ░ ▒▓█  ▄                                   "
echo "              ▒▒█████▓ ░██████▒▒██▒ ░ ░██░▒██▒   ░██▒ ▓█   ▓██▒ ▒██▒ ░ ░▒████▒                                  "
echo "              ░▒▓▒ ▒ ▒ ░ ▒░▓  ░▒ ░░   ░▓  ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒ ░░   ░░ ▒░ ░                                  "
echo "              ░░▒░ ░ ░ ░ ░ ▒  ░  ░     ▒ ░░  ░      ░  ▒   ▒▒ ░   ░     ░ ░  ░                                  "
echo "               ░░░ ░ ░   ░ ░   ░       ▒ ░░      ░     ░   ▒    ░         ░                                     "
echo "                 ░         ░  ░        ░         ░         ░  ░           ░  ░                                  "
echo "                                                                                                   "
echo "  ███▄    █  ███▄ ▄███▓ ▄▄▄       ██▓███         ██▓███   ▄▄▄       ██▀███    ██████ ▓█████  ██▀███   "
echo "  ██ ▀█   █ ▓██▒▀█▀ ██▒▒████▄    ▓██░  ██▒      ▓██░  ██▒▒████▄    ▓██ ▒ ██▒▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒ "
echo " ▓██  ▀█ ██▒▓██    ▓██░▒██  ▀█▄  ▓██░ ██▓▒      ▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒░ ▓██▄   ▒███   ▓██ ░▄█ ▒ "
echo " ▓██▒  ▐▌██▒▒██    ▒██ ░██▄▄▄▄██ ▒██▄█▓▒ ▒      ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒   ██▒▒▓█  ▄ ▒██▀▀█▄   "
echo " ▒██░   ▓██░▒██▒   ░██▒ ▓█   ▓██▒▒██▒ ░  ░      ▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒▒██████▒▒░▒████▒░██▓ ▒██▒ "
echo " ░ ▒░   ▒ ▒ ░ ▒░   ░  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░      ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░ "
echo " ░ ░░   ░ ▒░░  ░      ░  ▒   ▒▒ ░░▒ ░           ░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░ "
echo "    ░   ░ ░ ░      ░     ░   ▒   ░░             ░░         ░   ▒     ░░   ░ ░  ░  ░     ░     ░░   ░  "
echo "          ░        ░         ░  ░                           ░  ░   ░           ░     ░  ░   ░      "                                                                                                        
echo -e "\e[39m"																				 
echo -e "\e[96mVersion: $version - $modified 	Created By: Shifty0g 	https://github.com/shifty0g  \e[39m	" 
echo "-----------------------------------------------------------------------------------------------------------"
}

function footer () {
# footer to print out at the end of the script 
echo "-----------------------------------------------------------------------------------------------------------"
echo "				           ___                           "
echo "				  _  _  .-'   '-.                        "
echo "				 (.)(.)/         \                       "
echo "				  /@@             ;                      "
echo "				 o_\\-mm-......-mm\`~~~~~~~~~~~~~~~~\`   "
echo "				                                         "                                          
echo 
}

function helpmenu () {
# prints out the header and help menu when --help switch is selected to show the options to use 
echo 
echo "[*] Usage: $fname [input] [options]"
echo
echo -e "\e[95m[input]:		Grepable nmap file(s) .gnmap - can have multiple\e[39m"
echo
echo -e "\e[93m[options]:"
echo 
echo "	--help		Show this help menu"
echo "	--all		Runs ALL options - EXCLUDING: report1"
echo "	--csv		Create .csv file - $outputcsvfile"
echo "	--summary	Create host Summary report - $outputsummaryfile"
echo "	--closed	Create Summary of hosts with CLOSED ports - $outputclosedfile"
echo "  	--report1   	Report - IP[PORT1,PORT2,PORT3, ] - parsip.pl" 
echo "	--unique	Parse open unique TCP & UDP ports - $outputuniquefile"
echo "	--tcp		Parse open TCP ports - $outputtcpfile"
echo "	--udp		Parse open UDP ports - $outputudpfile"
echo "	--up		Parse 'Up' hosts - $outputupfile"
echo "	--down		Parse 'Down' hosts - $outputdownfile"
echo "	--ippport	Parse targets IP:PORT - $outputipfile"
echo "	--smb		Generate smb paths smb://IP - $outputsmbfile"
echo "	--web		Generate web URLS http://IP:PORT https://IP:PORT  - $outputwebfile"
echo "	--ssl		Generate ssl/tls hosts list IP:PORT - $outputsslfile"
echo "	--hostports	Generate hosts/hosts_<PORT>-<PROTOCOL>-<SERVICE>.txt files"
echo 
echo -e "\e[39m[*] Example:"
echo 
echo "$fname *.gnmap --all"
echo "$fname nmap_tcp_full.gnmp nmap_udp_def.gnmap --summary --unique"
echo "$fname nmap_tcp_full.gnmp nmap_udp_def.gnmap --web"
echo
echo "-----------------------------------------------------------------------------------------------------------"
echo
exit
}

function diagnostics () {
# diagnostics function used to help figure out whats wrong - will delete this when release the script 
echo
echo
echo "################################[ DIAGNOSTICS ]########################################"
echo "\$0 - "$0
echo "\$1 - "$1
echo "\$* - "$*
echo "inpputfile - "$file
echo "inputfilepath - "$inputfilepath
echo "tempfile - "$tempfile
echo "outpath - "$outpath
echo "filecheck - "$filecheck
echo "#######################################################################################"
}

function makecsv () {
# this is the main function which processes the inputfile and creates a csv file 
echo -e "\e[1m\e[93m[>]\e[0m Creating CSV File"
while read line; do
	checkport=$(echo $line | grep -e '/open/' -e '/closed')
	if [ "$checkport" != "" ]; then
		host=$(echo $line | awk '{print $2}')
		lineports=$(echo $line | awk '{$1=$2=$3=$4=""; print $0}')
		if [ -f ${outpath}"tempfile2" ]; then rm ${outpath}"tempfile2"; fi
		echo "$lineports" | tr "," "\n" | sed 's/^ *//g' >> ${outpath}"tempfile2"
		# Read the per-host temp file to write each open port as a line to the CSV temp file
		while read templine; do
		# check for open port
		checkport2=$(echo $templine | grep -e '/open/' -e '/closed')
		if [ "$checkport2" != "" ]; then
			port=$(echo $templine | awk -F '/' '{print $1}')
			status=$(echo $templine | awk -F '/' '{print $2}')
			protocol=$(echo $templine | awk -F '/' '{print $3}')
			service=$(echo $templine | awk -F '/' '{print $5}')
			version=$(echo $templine | awk -F '/' '{print $7}')
			echo "$host,$port,$status,$protocol,$service,$version" >> ${outpath}"temp.csv"
		fi
		done < ${outpath}"tempfile2"
	fi
done < ${outpath}"inputfile" 

# finalise and move the file if temp.csv
if [ -f ${outpath}"temp.csv" ]; then
   echo "HOST,PORT,STATUS,PROTOCOL,SERVICE,VERSION" > ${outpath}$outputcsvfile 
   # sort by ip address - 1st.2nd.3rd.4th
   cat ${outpath}"temp.csv" | sort -t"," -n -k1 | $sortip >> ${outpath}$outputcsvfile 
fi

#cleanup 
rm ${outpath}"temp.csv" ${outpath}"tempfile2" > /dev/null 2>&1

echo "	- $outputcsvfile"
echo
}

function checkcsv () {
# checks if the makecsv function has already ran and then sets the tempfile varible - stops repition as most other functions use the csv file 
if [ "$men_csv" == "Y" ]
then
	cp ${outpath}$outputcsvfile ${outpath}"tempinput"
else
	makecsv > /dev/null 2>&1
	mv ${outpath}$outputcsvfile ${outpath}"tempinput"
fi

# remove the head from the csv file 
sed -i -e "1d" ${outpath}"tempinput"

# remove lines that have closed ports 
sed -i '/,closed,/d' ${outpath}"tempinput"

export tempfile=$(realpath ${outpath}"tempinput")
}

function summary () {
# creates the summary file of from the input of open ports 
echo -e "\e[1m\e[93m[>]\e[0m Creating Summary"

#check for csv file to process 
checkcsv

#clear any old file - fresh
rm ${outpath}$outputsummaryfile > /dev/null 2>&1


echo "+=========================================================================================+" >> ${outpath}$outputsummaryfile
printf "%-18s %-16s %-52.52s %-2s \n" "| HOST " "| PORT / PROTOCOL" " | SERVICE" "|" >> ${outpath}$outputsummaryfile
lasthost=""
while read line; do
	host=$(echo $line | awk -F ',' '{print $1}')
	port=$(echo $line | awk -F ',' '{print $2}')
	protocol=$(echo $line | awk -F ',' '{print $4}')
	service=$(echo $line | awk -F ',' '{print $5}')
	version=$(echo $line | awk -F ',' '{print $6}')
	if [ "$host" != "$lasthost" ]; then echo "+=========================================================================================+" >> ${outpath}$outputsummaryfile; fi
	if [ "$version" = "" ]; then
	version=""
	else
	version="- $version"
	fi
	printf "%-18s %-16s %-52.52s %-2s \n" "| $host " "| $port / $protocol " "  | $service $version" " |" >> ${outpath}$outputsummaryfile
	lasthost="$host"
done < $tempfile
echo "+=========================================================================================+" >> ${outpath}$outputsummaryfile

#cleanup
rm  $tempfile > /dev/null 2>&1


echo "	- $outputsummaryfile"
echo
}

function ipport () {
# creates a file of open ports IP:PORT
echo -e "\e[1m\e[93m[>]\e[0m Creating IP Port file "

# check is csv is run and get a tempfile 
checkcsv

#clear any old file - fresh
rm ${outpath}$outputipfile > /dev/null 2>&1

# finalise the file and clean up 
cat $tempfile  | cut -d, -f1,2 | tr -d '"' | tr , : | $sortip > ${outpath}$outputipfile

#cleanup
rm  $tempfile > /dev/null 2>&1


echo "	- $outputipfile"
echo
}

function uphosts () {
# creates a file with IPs for hosts with Up Statues - needs further checks to be better 
echo -e "\e[1m\e[93m[>]\e[0m Parsing up hosts"
cat $inputfilepath | grep 'Status: Up' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort -u | $sortip  > ${outpath}$outputupfile 
echo "	- $outputupfile"
echo
}

function downhosts () {
# creates a file with IPs for hosts with Down status 
echo -e "\e[1m\e[93m[>]\e[0m Parsing down hosts"
cat $inputfilepath | grep 'Status: Down' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort -u | $sortip > ${outpath}$outputdownfile
echo "	- $outputdownfile"
echo
}

function uniqueports () {
# creates a file listing out uniquie open TCP and UDP ports
echo -e "\e[1m\e[93m[>]\e[0m Parsing unique ports"
cat $inputfilepath | grep -o -P '.{0,9}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort -u | paste -s -d, 2>&1 > ${outpath}$outputuniquefile; 
echo "	- $outputuniquefile"
echo
}

function tcpports () {
# creates a file of unqiue open TCP ports - 22,23,80,443...
echo -e "\e[1m\e[93m[>]\e[0m Parsing tcp ports"
cat $inputfilepath | grep '/tcp/' | grep -o -P '.{0,9}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique | paste -s -d, 2>&1 > ${outpath}$outputtcpfile;
echo "	- $outputtcpfile"
echo
}

function udpports () {
# creates a file of unqiue open UDP ports - 53,161...
echo -e "\e[1m\e[93m[>]\e[0m Parsing udp ports"
cat $inputfilepath | grep '/udp/'  | grep -o -P '.{0,9}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique | paste -s -d, 2>&1 > ${outpath}$outputudpfile
echo "	- $outputudpfile"
echo
}

function smb () {
# createa file for URI smb://192.168.1.1 
echo -e "\e[1m\e[93m[>]\e[0m Creating smb paths"
cat $inputfilepath | grep '445/open' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sed -e 's/^/smb:\/\//' | sort -u | $sortip | sort -t'/' -k2 -V  > ${outpath}$outputsmbfile
echo "	- $outputsmbfile"
echo
}

function web () {
# make a file of URLS to use with tools like nikto wafwoof est
echo -e "\e[1m\e[93m[>]\e[0m Creating web URLS"

# start fresh
rm ${outpath}$webfinalname ${outpath}webtemp2  > /dev/null 2>&1

#check that the csv file has been created
checkcsv

for line in $(cat $tempfile); do
	host=$(echo $line | awk -F ',' '{print $1}')
	port=$(echo $line | awk -F ',' '{print $2}')
	service=$(echo $line | awk -F ',' '{print $5}')
	version=$(echo $line | awk -F ',' '{print $6}')
	
	# a little overboard with the checks just to make sure all web ports are collected
	if [ "$port" = "80" ]; then echo "http://${host}:80/" >> ${outpath}webtemp2; fi
    if [ "$port" = "443" ]; then echo "https://${host}:443/" >> ${outpath}webtemp2; fi
    if [ "$port" = "8080" ]; then echo "http://${host}:8080/" >> ${outpath}webtemp2; fi
    if [ "$port" = "8443" ]; then echo "https://${host}:8443/" >> ${outpath}webtemp2; fi
	if [ "$service" = "http" ]; then echo "http://${host}:$port/" >> ${outpath}webtemp2; fi
	if [ "$service" = "ssl|http" ]; then echo "https://${host}:$port/" >> ${outpath}webtemp2; fi
	if [ "$version" = "*Web*" ]; then echo "http://${host}:$port/" >> ${outpath}webtemp2; fi
	if [ "$version" = "*web*" ]; then echo "http://${host}:$port/" >> ${outpath}webtemp2; fi
done

#sort by IP
sort -u ${outpath}webtemp2 | $sortip | sort -t'/' -k2 -V  > ${outpath}$outputwebfile 

#cleanup
rm ${outpath}webtemp2 $tempfile  > /dev/null 2>&1

echo "	- $outputwebfile"
echo
}

function ssl () {
echo -e "\e[1m\e[93m[>]\e[0m Creating ssl/tls list"

# start fresh
rm ${outpath}$outputsslfile ${outpath}ssltemp2 > /dev/null 2>&1

#check that the csv file has been created
checkcsv

for line in $(cat $tempfile); do
	host=$(echo $line | awk -F ',' '{print $1}')
	port=$(echo $line | awk -F ',' '{print $2}')
	service=$(echo $line | awk -F ',' '{print $5}')
	version=$(echo $line | awk -F ',' '{print $6}')
	
	# a little overboard again
	if [ "$port" = "443" ]; then echo "${host}:$port" >> ${outpath}ssltemp2; fi
	if [ "$service" = "*ssl*" ]; then echo "${host}:$port" >> ${outpath}ssltemp2; fi
	if [ "$version" = "*ssl*" ]; then echo "${host}:$port" >> ${outpath}ssltemp2; fi
	if [ "$service" = "*tls*" ]; then echo "${host}:$port" >> ${outpath}ssltemp2; fi
	if [ "$version" = "*tls*" ]; then echo "${host}:$port" >> ${outpath}ssltemp2; fi
done

#sort by IP
sort -u ${outpath}ssltemp2 | $sortip > ${outpath}$outputsslfile 

#clean up function
rm ${outpath}ssltemp ${outpath}ssltemp2 $tempfile > /dev/null 2>&1

echo "	- $outputsslfile"
echo
}

function hostports () {
# will create a folder hosts and generate ip lists for each open ports for example 80 http will be hosts/hosts_80-tcp-http.txt
# need to reqord some fo the service names to make them a little better 
echo -e "\e[1m\e[93m[>]\e[0m Generating host port files"

# fresh folder
rm ${outpath}$outhostsdir -rf > /dev/null 2>&1

# make folder - this can be spammy
mkdir ${outpath}$outhostsdir > /dev/null 2>&1
hostportspath=$(realpath $outpath$outhostsdir)

#check that the csv file has been created
checkcsv

# loop through and Create split hosts files for each protocol
for line in $(cat $tempfile); do
	host=$(echo $line | awk -F ',' '{print $1}')
	port=$(echo $line | awk -F ',' '{print $2}')
	proto=$(echo $line | awk -F ',' '{print $4}')
	service=$(echo $line | awk -F ',' '{print $5}' | tr -d '-' | tr -d '?' | tr -d '|' )
	# need to add better service names	
    echo $host >> $hostportspath"/hosts_"$port-$proto-$service.txt
done

#function cleanup
rm  ${hostportspath}/hosts_--.txt $tempfile > /dev/null 2>&1


echo "	- "$hostportsfolder"/hosts_*.txt"
echo
}

function closedsummary() {
# creates a little report of hosts with closed ports
echo -e "\e[1m\e[93m[>]\e[0m Generating  Closed Ports Summary"

rm ${outpath}$outputclosedsummaryfile > /dev/null 2>&1
for host in $(cat $inputfilepath | grep "Host:" | grep "\/closed\/" | awk '{ print $2}'| sort --unique); do # will go through each host
    echo "Closed Ports For Host: $host " >> ${outpath}$outputclosedsummaryfile
	echo -n "	" >> ${outpath}$outputclosedsummaryfile
    for port in $(cat $inputfilepath | grep -w $host | grep -o -P '.{0,10}/closed/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
		echo -n $port", " >> ${outpath}$outputclosedsummaryfile
    done # end ports loop
	echo -e "\n " >> ${outpath}$outputclosedsummaryfile
done # end hosts loop

# old oneliner
#cat $inputfilepath |awk '/closed/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}' |grep -v open |grep -v "-" |sed "s/[/].*//" | grep -e '[[:digit:]]*\|"\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"' |sed 's/(//' |sed 's/)//' |sed "s/[a-zA-Z']/ /g" |sed -r '/^\s*$/d' |sed 's/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/\nBREAK Closed Ports For Host: &\n/' |paste -s -d,| sed 's/Closed/\n&/g'|sed 's/^\(, ,\)*//' | sed 's/,*$//g' |sed  -e 's/, ,/-/g' |tr - '\n' |sed 's/BREAK/\'$'\n/g' | sed 's/,,$//' > ${outpath}$closedsummaryname

echo "	- "$outputclosedsummaryfile
echo
}

function report1() {
# create a different type of report like  parsip - will produce same output as nmap-parse.py

echo -e "\e[1m\e[93m[>]\e[0m Generating Report1"

# start fresh
rm ${outpath}$outputreport1file ${outpath}"reportemp" > /dev/null 2>&1

for host in $(cat $inputfilepath | grep "Host:" | grep "\/open\/" | awk '{ print $2}'| sort --unique); do # will go through each host
    echo -n $host  "[" >> ${outpath}"reportemp"
    for port in $(cat $inputfilepath | grep -w $host | grep -o -P '.{0,10}/open/' | awk '{ print $2}' | cut -d /  -f 1 | sort --unique); do # go through ports
		echo -n $port", " >> ${outpath}"reportemp"
    done # end ports loop
    echo  "]" >> ${outpath}"reportemp"
done # end hosts loop
cat ${outpath}"reportemp" | $sortip | grep -v "\[\]"  >  ${outpath}$outputreport1file


echo "	- "$outputreport1file
echo
}



########################
# MAIN 
########################


# look trough and check inputfile and switches
for word in $(echo $*); do
	#echo $word
	if [[ $word == *".gnmap"* ]]; then
		file+="$word "
	fi
	if [ $word == "--help" ]; then
		header
		helpmenu
		switch+="$word"
	fi
	if [ $word == "--csv" ]; then
		men_csv="Y"
		switch+="$word"
	fi
	if [ $word == "--summary" ]; then
		men_summary="Y"
		switch+="$word"
	fi
	if [ $word == "--unique" ]; then
		men_uports="Y"
		switch+="$word"
	fi
	if [ $word == "--up" ]; then
		men_uphosts="Y"
		switch+="$word"
	fi
	if [ $word == "--down" ]; then
		men_downhosts="Y"
		switch+="$word"
	fi
	if [ $word == "--ipport" ]; then
		men_ipport="Y"
		switch+="$word"
	fi
	if [ $word == "--smb" ]; then
		men_smb="Y"
		switch+="$word"
	fi
	if [ $word == "--web" ]; then
		men_web="Y"
		switch+="$word"
	fi
	if [ $word == "--ssl" ]; then
		men_ssl="Y"
		switch+="$word"
	fi
	if [ $word == "--tcp" ]; then
		men_tcpports="Y"
		switch+="$word"
	fi
	if [ $word == "--udp" ]; then
		men_udpports="Y"
		switch+="$word"
	fi
	if [ $word == "--hostports" ]; then
		men_hostports="Y"
		switch+="$word"
	fi	
	if [ $word == "--closed" ]; then
		men_closed="Y"
		switch+="$word"
	fi		
	if [ $word == "--report1" ]; then
		men_report1="Y"
		switch+="$word"
	fi	
	if [ $word == "--all" ]; then
		#include 
		men_all="Y"
		men_csv="Y"
		men_summary="Y"
		men_uports="Y"
		men_tcpports="Y"
		men_udpports="Y"
		men_uphosts="Y"
		men_downhosts="Y"
		men_ipport="Y"
		men_smb="Y"
		men_ssl="Y"
		men_web="Y"
		men_hostports="Y"
		men_closed="Y"
		
		#exclude
		men_report1="N"
		
		#Create $outdir to put all outout in - stop spam
		createoutdir="Y"
		switch+="$word"
	fi	
done

# check for valid file
if [ -z "$file" ]
then
	  #header
	  echo 
      echo -e "\e[1m\e[91m[X] No input files FOUND - *.gnmap file required! [X]\e[0m"
	  echo 
	  helpmenu
	  exit 
else
	# further checks on the file - is it valid 
	#filecheck=$(file $file | grep -o -e ASCII && head $file | grep -o -e "\-oA" -e "\-oG")
	#if [ !-z "$filecheck" ]
	
	if [ ! -z "$(file $file | grep -o -e ASCII && head $file | grep -o -e "\-oA" -e "\-oG")" ]
	then
		#sort out the file here 
		cat $(realpath $file)| sort -V  > inputfile
		#cat $(realpath $file) | sort -t"," -n -k1 | sort -t"." -n -k1 | sort -t"." -n -k2 | sort -t"." -n -k3 | sort -t"." -n -k4 > inputfile
	fi
fi


# check valid switches
if [ -z "$switch" ] 
then
	  #header
	  echo 
      echo -e "\e[1m\e[91m[X] No Valid Switches FOUND - --csv, --all, etc.. [X]\e[0m"
	  echo 
	  helpmenu
	  exit  
fi




                                         
header
echo 

# if all is selected make the outdir folder - stop the spam
if [ "$createoutdir" == "Y" ]
then 
	export outpath="$(realpath $outdir)/"
	mkdir $outdir > /dev/null 2>&1
	mv inputfile $outdir
	export inputfilepath=$(realpath $outdir"/inputfile")
else
	export outpath=$(pwd)"/"
	export inputfilepath=$(realpath "inputfile")
fi


#1 -- make csv file
if [ "$men_csv" == "Y" ]; then makecsv; fi
#2 - summary (uses makecsv)
if [ "$men_summary" == "Y" ]; then summary; fi
# rest
if [ "$men_ipport" == "Y" ]; then ipport; fi
if [ "$men_uports" == "Y" ]; then uniqueports; fi
if [ "$men_tcpports" == "Y" ]; then	tcpports; fi
if [ "$men_udpports" == "Y" ]; then	udpports; fi
if [ "$men_uphosts" == "Y" ]; then uphosts; fi
if [ "$men_downhosts" == "Y" ]; then downhosts; fi
if [ "$men_smb" == "Y" ]; then smb; fi
if [ "$men_web" == "Y" ]; then web; fi
if [ "$men_ssl" == "Y" ]; then ssl; fi
if [ "$men_hostports" == "Y" ]; then hostports; fi
if [ "$men_closed" == "Y" ]; then closedsummary; fi
if [ "$men_report1" == "Y" ]; then report1; fi


# MASTER cleanup - lazy (each function should cleanup too but this needs to be checked also )
rm ${outpath}"tempinput" ${outpath}"ipptemp" ${outpath}"closedtemp" ${outpath}"summtemp"  ${outpath}"tempfile" ${outpath}$varTempFile2 ${outpath}"inputfile" ${outpath}$varTempFile ${outpath}$tempfile ${outpath}$varSummTempFile ${outpath}"webtemp" ${outpath}"webtemp2" ${hostportspath}"hostptemp" > /dev/null 2>&1





# print footer once completed 
footer


# if yes will print the output - maybe flip this around so ENTER is for yes
echo 
read -p "[-] Display Output? <ENTER = YES / anything else = NO> : " prompt
echo
if [ -z "$prompt" ]
then
	more ${outpath}*.txt
	if [ "$men_hostports" == "Y" ]; then  more ${hostportspath}"/hosts_"*.txt; fi
fi

# remove comment to enable diagnostics function
#diagnostics


# exit 
exit 0



#----------------------------------------------------------------- END OF SCRIPT -----------------------------------------------------------------
