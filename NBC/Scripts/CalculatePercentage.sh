#!/bin/bash
cat outtestCombined.txt | awk '{print $6}' | sed 's/.$//' > extracttestCombined.txt
count=`cat outtestCombined.txt | wc -l`
sort extracttestCombined.txt | uniq -c | sort -bnr > countedCombined.txt
awk -v c="$count" '{ $1 /= c*0.01; print }' OFS='\t' countedCombined.txt  > CalculatedPercentage.txt


