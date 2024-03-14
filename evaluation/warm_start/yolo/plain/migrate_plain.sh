#!/bin/bash

for j in {10,20,30,40,50}
do
	for i in {1..30}
	do
		sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name yolo --init --mount type=bind,source=/mnt/checkpointfs,target=/checkpointfs -p 7878:7878 -p 1000-10$j:1000-10$j tul11/cluster_migration:yolo fastfreeze run -vvv --image-url file:/checkpointfs/ff_yolo --  /root/entrypoint.sh
		sleep 5
		start_migrate=`date +%s%N`
		sudo docker exec yolo fastfreeze checkpoint -vvv
		ssh tul@node2 "sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --init --name yolo --mount type=volume,source=chkfs,target=/checkpointfs -p 7878:7878 -p 1000-10$j:1000-10$j tul11/cluster_migration:yolo fastfreeze run -vvv --image-url file:/checkpointfs/ff_yolo --  /root/entrypoint.sh"	
		end_migrate=`date +%s%N`
		echo "Execution Time is: $(($end_migrate-$start_migrate)) nanoseconds"
		echo $(($end_migrate-$start_migrate)) >> plain_$j.out
		sleep 5
		ssh tul@node2 "sudo docker kill yolo"
		sudo rm -rf /mnt/checkpointfs/ff_yolo
	done
done
