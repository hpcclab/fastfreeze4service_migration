#!/bin/bash

for i in {1..30}
do 
	sudo docker stats --no-stream memhog_d >> ffd.out 
	sleep 5
done
