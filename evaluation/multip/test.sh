#!/bin/bash

curl -X POST -H "Content-Type:application/json" -d @run.json http://127.0.0.1:7878/run -i
sleep 10
for i in {1..30} 
do 
	echo "ROUND $i"
	curl -X POST -H "Content-Type:application/json" -d @chk.json http://127.0.0.1:7878/checkpoint -i
	curl -X POST -H "Content-Type:application/json" -d @run.json http://127.0.0.1:7878/run -i
	curl -X POST -H "Content-Type:application/json" -d @run.json http://127.0.0.1:7878/run -i
	sleep 20
done

echo "Experiment done!"
