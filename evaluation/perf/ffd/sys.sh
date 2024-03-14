#!/bin/bash

ff_daemon &
for i in {1..30}
do
	sysbench cpu run | grep "events per second" >> /result/sys_cpu_ffd.out
done

for i in {1..30}
do
        sysbench memory run | grep "transferred" >> /result/sys_mem_ffd.out
done

sysbench fileio --file-test-mode=rndrw prepare
for i in {1..30}
do
        sysbench fileio --file-test-mode=rndrw run > io.out
        grep "read, MiB/s:" io.out >> /result/sys_read_ffd.out
        grep "written, MiB/s:" io.out >> /result/sys_write_ffd.out
done

sysbench fileio --file-test-mode=rndrw cleanup


