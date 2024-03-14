#!/bin/bash

for j in {1020,1030,1040,1050}
do
	for i in {1..30}
	do
		sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name memhog --init --mount type=bind,source=/mnt/checkpointfs,target=/checkpointfs -p 7878:7878 -p 1000-${j}:1000-${j} fastfreeze:memhog ff_daemon
		ssh tul@node2 "sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name memhog --init --mount type=volume,source=chkfs,target=/checkpointfs -p 7878:7878 -p 1000-${j}:1000-${j} tul11/cluster_migration:memhog ff_daemon"
		sleep 1
		curl -X POST -H "Content-Type:application/json" -d @run.json http://127.0.0.1:7878/run -i
		sleep 5
		start_migrate=`date +%s%N`
		curl -X POST -H "Content-Type:application/json" -d @chk.json http://127.0.0.1:7878/checkpoint -i 
		curl -X POST -H "Content-Type:application/json" -d @run.json http://192.168.50.52:7878/run -i
		end_migrate=`date +%s%N`
		echo "Execution Time is: $(($end_migrate-$start_migrate)) nanoseconds"
		echo $(($end_migrate-$start_migrate)) >> fixed_${j}.out
		sleep 5
		ssh tul@node2 "sudo docker kill memhog"
		sudo docker kill memhog
		sudo rm -rf /mnt/checkpointfs/ff_memhog
	done
	echo "Finish for ${j}"
done
