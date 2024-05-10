# fastfreeze4service_migration (FastMig)

## Introduction
This project aim to develop a robust live containerized service migration solution to realise service liquidity, desired for Cloud 2.0. We adapt *[FastFreeze](https://github.com/twosigma/fastfreeze)*, a turn-key container checkpoint/restore solution to develop *FastMig* by addressing on several aspects: 
  - Service Management Decoupling: Serperate the service and container live time allowing post-checkpointing/pre-restoration operations
  - Fault tolerance mechanism: Provide a fault handling modules to determine service start-up options after faults
  - The FastMig Interfaces: Provide standardized HTTP interfaces for migration operations

## Prerequisite
- FastMig will only work on Linux kernel version >= 5.9

## Usage
User can build their container images by using the FastMig image as container base image for ubuntu:20.04 base container eg.
```Dockerfile
FROM ghcr.io/hpcclab/fastfreeze4service_migration/fastmig:memhog
```
or build from source by using example in the [Dockerfile](./Dockerfile).

To run the service, user will start the container with *ff_daemon* as the command with desire arguments.
```
docker run --cap-add=cap_sys_ptrace --init  ... ff_daemon [OPTIONS]

OPTIONS:
  -k      kill the container when service exit. 
  -e      path for ff_daemon to read the json in 
          the same form as the RunAPI to determine 
          how the service will be started.
  -d      path of the file that will indicate the start mode. 
          Default=/decider.txt
  -p      port that ff_daemon will listen for request. Default=7878
```
It is recommended to use FastMig with some docker options for multi-processes services (see [FastFreeze Multi-processes Improvement](/multi-processes_improvement/)).

You can use the APIs to control the checkpoint/restore operation.
The APIs specification is presented with OpenAPI form [here](https://app.swaggerhub.com/apis-docs/SorawitMANATURA-101/api-specification_for_fastfreeze/1.0#/).

The request payloads of the APIs are mostly identical to [FastFreeze](https://github.com/twosigma/fastfreeze) options. 

## Migration
To migrate a service(assuming from A->B), user can started service's container at B with standby mode then request checkpoint service at A and restore at B.

**Example script of migrate operation**
```bash
#!/bin/bash
#Script run at A

#Start container at B with standby mode(default mode)
ssh user@nodeB "sudo docker run -d --rm --cap-add=cap_sys_ptrace ... ff_daemon"
#Checkpoint at A
curl -X POST -H "Content-Type:application/json" -d @chk.json http://nodeA:7878/checkpoint -i
#Restore at B
curl -X POST -H "Content-Type:application/json" -d @run.json http://nodeB:7878/run -i
```









