#!/bin/bash
curl "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/tif-onlydomains.txt" -o 1.txt ;
#curl "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.medium.txt" -o 2.txt ;
#cat 1.txt 2.txt > merge1.txt ;
echo "merge  done" ;
sort 1.txt | uniq > final1.txt ;
sed '/^#/d' final1.txt > domains1.txt ;
split -l 300000 domains1.txt ;
echo "base64 1 start" ;
cat /dev/null > domains_iocs1.list ; 
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < xaa > domains_iocs1.list ;
echo "base64 2 start" ;
cat /dev/null > domains_iocs2.list ;
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < xab > domains_iocs2.list ;
echo "base64 3 start" ;
 cat /dev/null > domains_iocs3.list ; 
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < xac > domains_iocs3.list ;
#rm 1.txt final1.txt  ;
echo "50% done" ;

#wc -l 1.txt
#curl "https://raw.githubusercontent.com/xRuffKez/NRD/main/nrd-14day.txt"  -o 1.txt ;
#curl "https://raw.githubusercontent.com/xRuffKez/NRD/main/nrd-14day.txt"  -o 2.txt ;
#cat  2.txt domains1.txt > merge2.txt ;
#sort merge2.txt | uniq > final2.txt ;
#echo "merge 2 done" ;
#sed '/^#/d' final2.txt > domains2.txt ;
#echo "base64 2 start" ;

#cat /dev/null > domains_iocs2.list ;
#while IFS= read -r line; do echo -n $line | base64 -w 1000; done < domains2.txt > domains_iocs2.list ;
#echo "base64 2 done" ;

rm  1.txt 2.txt domains1.txt domains2.txt final2.txt merge2.txt xaa xab xac ;
echo "100% done" ;
chown --reference=suricata.yaml domains_iocs1.list domains_iocs2.list domains_iocs3.list ; 
docker restart suricata
exit
