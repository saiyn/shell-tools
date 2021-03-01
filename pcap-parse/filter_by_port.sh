#!/bin/bash



let suffix=0
let filename_suffix_max=49

declare -A ports_map

#ports_map=(["http_80"]=80 ["http_8080"]=8080 ["https_443"]=443 ["https_8443"]=8443 ["netbios"]=137 ["ssh"]=22 ["cups"]=631 ["upnp"]=1900 ["wsdd"]=3702 ["dhcp"]=68)
ports_map=(["dhcp_rsp"]=68 ["dhcp_qey"]=67)

function next_file(){
    if [ $suffix -lt $filename_suffix_max ]; then
	        printf "./ap2000%02d" "$suffix"
		else
			echo "eof"
	fi
}

function get_protocol_cnt() {

	cnt=`tcpdump port $2 -xnr $1 | wc -l`

	echo $cnt
}

for index in "${!ports_map[@]}"



do
	suffix=0

	while true
	do

		file_name=$(next_file)

		suffix=$((suffix+1))

		if [ $file_name = "eof" ]; then
			break
		else

			echo ${ports_map[$index]}

			cnt=`get_protocol_cnt $file_name ${ports_map[$index]}`
			echo $cnt

			if [ $cnt -gt 0 ]; then
				suf=".pcap"
				newfile=`echo $file_name$suf | cut -c3-15`

				mkdir -p ./SAIYN_CHEN/$index
				
				tcpdump port ${ports_map[$index]} -xnr $file_name -w ./SAIYN_CHEN/$index/$newfile
			fi
		fi
	done
done
