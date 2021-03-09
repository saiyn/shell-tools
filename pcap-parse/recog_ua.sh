#/bin/bash


declare -A ua_array



for file in ~/ap2000_ua_mac/*.txt; do
	echo "start parse "$file

    ip_array=()

    mac="$(basename $file .txt)"    

	while read p; do
		ua=`echo $p | cut -f 3- -d ' '`


		if [[ -v ua_array["$ua"] ]]; then
			((ua_array["$ua"]++))

            echo $ua" get times: "${ua_array["$ua"]}

		else
			ua_array["$ua"]=1

           echo "first get ua "$ua

		fi

        ip=`echo $p | awk '{print $2}'`

        if [[ ! " ${ip_array[@]} " =~ " ${ip} " ]]; then
            ip_array+=($ip)
            echo "get ip "$ip
        fi
        

	done < $file

    suffix=".txt"
    newfile=~/ap2000_ua_merge/$mac-$ip$suffix


    echo $newfile

    touch $newfile

	for keys in "${!ua_array[@]}"; do
        echo ${ua_array[$keys]} $keys >> $newfile
    done

    for value in "${ua_array[@]}"; do
        echo $value
    done

    echo $mac
    
    echo ${ip_array[@]}

done
