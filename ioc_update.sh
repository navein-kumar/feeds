#!/bin/bash
curl "https://raw.githubusercontent.com/stamparm/blackbook/master/blackbook.txt" -o 1.txt &&
curl "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/tif.txt" -o 2.txt &&
cat 1.txt 2.txt > merge1.txt &&
sort merge1.txt | uniq > final1.txt &&
sed '/^#/d' final1.txt > domains1.txt &&
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < domains1.txt > domains_iocs1.list &&
rm 1.txt 2.txt merge1.txt final1.txt  &&

curl "https://raw.githubusercontent.com/xRuffKez/NRD/main/nrd-30day_part1.txt"  -o 1.txt &&
curl "https://raw.githubusercontent.com/xRuffKez/NRD/main/nrd-30day_part2.txt"  -o 2.txt &&
cat 1.txt 2.txt domains1 > merge2.txt &&
sort merge2.txt | uniq > final2.txt &&
sed '/^#/d' final2.txt > domains2.txt &&
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < domains2.txt > domains_iocs2.list &&
rm  1.txt 2.txt domains1.txt domains2.txt final2.txt merge2.txt
