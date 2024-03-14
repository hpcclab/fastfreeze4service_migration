#!/bin/bash

for i in {4,8,16}
do
	sed -i 's/.$//' nfix_$i\_restore.txt
	sed -i 's/.$//' nfix_$i\_restore.txt
	awk '{ sum += $NF } END { if (NR > 0) print "Average = "sum / NR }' nfix_$i\_restore.txt  >> nfix_$i\_restore.txt
done
