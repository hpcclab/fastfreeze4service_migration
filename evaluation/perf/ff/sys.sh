#!/bin/bash

for i in {1..30}
do
	sysbench cpu run | grep "events per second" >> /result/sys_cpu_ffp.out
done

for i in {1..30}
do
        sysbench memory run | grep "transferred" >> /result/sys_mem_ffp.out
done

sysbench fileio --file-test-mode=rndrw prepare
for i in {1..30}
do
        sysbench fileio --file-test-mode=rndrw run > io.out
        grep "read, MiB/s:" io.out >> /result/sys_read_ffp.out
        grep "written, MiB/s:" io.out >> /result/sys_write_ffp.out
done

sysbench fileio --file-test-mode=rndrw cleanup


