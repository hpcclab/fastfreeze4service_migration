#!/bin/bash

for i in {1..30}
do 
	sudo docker stats --no-stream reg >> reg.out 
	sleep 5
done
