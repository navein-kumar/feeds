#!/bin/bash
curl "https://raw.githubusercontent.com/stamparm/blackbook/master/blackbook.txt" -o domains.txt &&
sed '/^#/d' domains.txt > domains1.txt &&
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < domains1.txt > domains_iocs.list &&
rm domains.txt domains1.txt &&
curl "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/tif.medium-onlydomains.txt"  -o domains.txt &&
sed '/^#/d' domains.txt > domains1.txt &&
while IFS= read -r line; do echo -n $line | base64 -w 1000; done < domains1.txt > domains1_iocs.list &&
rm domains.txt domains1.txt
