FROM ghcr.io/hpcclab/fastfreeze4service_migration/fastmig:latest

RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | sudo bash
RUN apt update && apt -y install sysbench iperf3