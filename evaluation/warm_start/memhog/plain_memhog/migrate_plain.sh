#!/bin/bash

for i in {1..30}
do
	sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name memhog --init --mount type=bind,source=/mnt/checkpointfs,target=/checkpointfs -p 7878:7878 -p 1000-1040:1000-1040 fastfreeze:memhog fastfreeze run -vvv --image-url file:/checkpointfs/ff_memhog --  /opt/memoryhog/entrypoint.sh
	sleep 5
	start_migrate=`date +%s%N`
	sudo docker exec memhog fastfreeze checkpoint -vvv
	ssh tul@node2 "sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name memhog --init --mount type=volume,source=chkfs,target=/checkpointfs -p 7878:7878 -p 1000-1040:1000-1040 tul11/cluster_migration:memhog fastfreeze run -vvv --image-url file:/checkpointfs/ff_memhog --  /opt/memoryhog/entrypoint.sh"	
	end_migrate=`date +%s%N`
	echo "Execution Time is: $(($end_migrate-$start_migrate)) nanoseconds"
	echo $(($end_migrate-$start_migrate)) >> plain_40.out
	sleep 5
	ssh tul@node2 "sudo docker kill memhog"
	sudo rm -rf /mnt/checkpointfs/ff_memhog
done
