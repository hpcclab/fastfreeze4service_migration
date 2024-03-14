#!/bin/bash

for i in {2,4,8,16}
do
	awk 'NR==1,NR==30{print $NF}'  nfix_$i\_restore.txt  >> nfix_$i\_extracted.txt
done

for i in {2,4,8,16}
do
	awk 'NR==1,NR==30{print $NF}'  fixed_$i\_restore.txt  >> fixed_$i\_extracted.txt
done
