#!/bin/bash

sysbench fileio --file-test-mode=rndrw prepare

for i in {1..30}
do
	sysbench fileio --file-test-mode=rndrw run > io.out
	grep "read, MiB/s:" io.out >> /iores/read_reg.out
	grep "written, MiB/s:" io.out >> /iores/write_reg.out
done

sysbench fileio --file-test-mode=rndrw cleanup
