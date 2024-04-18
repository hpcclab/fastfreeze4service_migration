FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install make libcap2-bin xz-utils wget curl git vim python3 gcc -y 
#RUN wget https://www.openssl.org/source/openssl-1.1.1v.tar.gz && tar xzf openssl-1.1.1v.tar.gz && \
#	cd openssl-1.1.1v && ./config && make && make install

# Install FastFreeze
COPY fastfreeze fastfreeze 
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/cargo PATH=/opt/cargo/bin:/usr/local/bin:$PATH
RUN cd fastfreeze && make && ln -s /opt/fastfreeze/fastfreeze /usr/local/bin  && fastfreeze install

RUN setcap 40,cap_sys_ptrace+eip /opt/fastfreeze/bin/criu
RUN setcap 40+eip /opt/fastfreeze/bin/set_ns_last_pid

#Build ff_daemon
COPY ff_daemon ff_daemon
RUN cd ff_daemon && cargo build && ln -s /ff_daemon/target/debug/ff_daemon /usr/local/bin


#directory use to exchange with controller
#RUN mkdir /opt/controller
