#/bin/bash

for file in ap2000*; do
	suffix=".pcap"
	tshark -r $file -Y http.request -Tfields -e eth.src -e ip.src -e http.user_agent > /home/saiyn/ap2000_ua/$file$suffix

	tshark -r $file -Y dns -Tfields -e eth.src -e ip.src -e dns.qry.name > /home/saiyn/ap2000_dns/$file$suffix
	
	tshark -r $file -Y dhcp -Tfields -e eth.src -e ip.src -e dhcp.option.hostname -e dhcp.hw.mac_addr -e dhcp.option.requested_ip_address > /home/saiyn/ap2000_dhcp/$file$suffix

    tshark -r $file -Y mdns -Tfields -e eth.src -e ip.src  -e dns.resp.name -e dns.resp.type -e dns.resp.class -e dns.resp.ttl -e dns.txt > /home/saiyn/ap2000_mdns/txt/$file$suffix

    tshark -r $file -Y mdns -Tfields -e eth.src -e ip.src -e dns.resp.name -e dns.resp.type -e dns.resp.class -e dns.resp.ttl -e dns.a > /home/saiyn/ap2000_mdns/a/$file$suffix
    
    sed -ie '/^[[:blank:]]*$/d' /home/saiyn/ap2000_mdns/txt/$file$suffix

    
    sed -ie '/^[[:blank:]]*$/d' /home/saiyn/ap2000_mdns/a/$file$suffix
    tshark -r $file -Y mdns -w /home/saiyn/ap2000_mdns_tshark/$file$suffix

done




