#!/bin/bash

for i in {1..30}
do 
	sudo docker stats --no-stream memhog_f >> ff.out 
	sleep 5
done
