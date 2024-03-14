#!/bin/bash

for i in {1..30}
do
	sudo docker run --rm ubuntu:perf sysbench memory run | grep "transferred" >> sys_mem_reg.out 
done
