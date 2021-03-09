#!/bin/bash

mac_array=()

function get_row_cnt() {
	echo $1 | awk -F ' ' '{print NF}'
}



function get_mac() {
	cut -f -1 -d ' ' $1
}


for file in ~/ap2000_ua/ap2000*.txt; do
	echo "start parse "$file

	while read p; do

		cnt=`echo $p | awk -F ' ' '{print NF}'`


		if [ $cnt -ge 3 ]; then
			mac=`echo $p | awk '{print $1}'`

			newfile="${file##*/}"
			suffix=".txt"
			if [[ ! " ${mac_array[@]} " =~ " ${mac} " ]]; then

				echo $p > /home/saiyn/ap2000_ua_mac/$mac$suffix
				mac_array+=($mac)

				echo "$mac is first got"
			else
				echo $p >> /home/saiyn/ap2000_ua_mac/$mac$suffix
				
			fi
		fi

	done < $file

done

			
