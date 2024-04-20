FROM ghcr.io/hpcclab/fastfreeze4service_migration/fastmig:latest
WORKDIR /root
RUN apt update \
    && apt install -y git wget make gcc g++ \
    && wget --no-check-certificate https://pjreddie.com/media/files/yolov3-tiny.weights \
    && git clone https://github.com/pjreddie/darknet \
    && cd darknet \
    && make
COPY entrypoint.sh /root
COPY main.c /opt/memoryhog/main.c
RUN cd /opt/memoryhog/ && gcc -Wall -O3 main.c -o memoryhog \
    && chmod +x /root/entrypoint.sh
WORKDIR /root/darknet
