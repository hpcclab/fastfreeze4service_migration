#!/bin/bash


for i in {1..30}
do
	sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name ff --init --mount type=bind,source=/mnt/checkpointfs,target=/checkpointfs -p 7878:7878 --env N=${j} tul11/cluster_migration:faultt ff_daemon
	ssh tul@node2 "sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name ff --init --mount type=volume,source=chkfs,target=/checkpointfs -p 7878:7878 --env N=${j} tul11/cluster_migration:faultt ff_daemon"
	sleep 1
	curl -X POST -H "Content-Type:application/json" -d @run_nf.json http://127.0.0.1:7878/run -i
	sleep 5
	start_migrate=`date +%s%N`
	curl -X POST -H "Content-Type:application/json" -d @chk.json http://127.0.0.1:7878/checkpoint -i
	curl -X POST -H "Content-Type:application/json" -d @run_nf.json http://192.168.50.52:7878/run -i
	end_migrate=`date +%s%N`
	echo "Execution Time is: $(($end_migrate-$start_migrate)) nanoseconds"
	echo $(($end_migrate-$start_migrate)) >> fault_0.out
	sleep 5
	ssh tul@node2 "sudo docker kill ff"
	sudo docker kill ff
	sudo rm -rf /mnt/checkpointfs/ff_f
done


for j in {10,100,1000,10000,100000,1000000}
do
	echo "start ${j}"
	for i in {1..30}
	do
		sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name ff --init --mount type=bind,source=/mnt/checkpointfs,target=/checkpointfs -p 7878:7878 --env N=${j} tul11/cluster_migration:faultt ff_daemon
		ssh tul@node2 "sudo docker run -d --rm --cap-add=cap_sys_ptrace   --cap-add=cap_checkpoint_restore  --name ff --init --mount type=volume,source=chkfs,target=/checkpointfs -p 7878:7878 --env N=${j} tul11/cluster_migration:faultt ff_daemon"
		sleep 1
		curl -X POST -H "Content-Type:application/json" -d @run.json http://127.0.0.1:7878/run -i
		sleep 5
		start_migrate=`date +%s%N`
		curl -X POST -H "Content-Type:application/json" -d @chk.json http://127.0.0.1:7878/checkpoint -i 
		curl -X POST -H "Content-Type:application/json" -d @run.json http://192.168.50.52:7878/run -i
		end_migrate=`date +%s%N`
		echo "Execution Time is: $(($end_migrate-$start_migrate)) nanoseconds"
		echo $(($end_migrate-$start_migrate)) >> fault_${j}.out
		sleep 5
		ssh tul@node2 "sudo docker kill ff"
		sudo docker kill ff
		sudo rm -rf /mnt/checkpointfs/ff_f
	done
done
