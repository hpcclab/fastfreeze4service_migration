# fastfreeze4service_migration (FastMig)

## Introduction
This project aim to develop a robust live containerized service migration solution to realise service liquidity, desired for Cloud 2.0. We adapt *[FastFreeze](https://github.com/twosigma/fastfreeze)*, a turn-key container checkpoint/restore solution to develop *FastMig* by addressing on several aspects: 
  - Service Management Decoupling: Serperate the service and container live time allowing post-checkpointing/pre-restoration operations
  - Fault tolerance mechanism: Provide a fault handling modules to determine service start-up options after faults
  - The FastMig Interfaces: Provide standardized HTTP interfaces for migration operations



