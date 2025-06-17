#!/usr/bin/env bash
config="A100"
LGCN_kernels=(16052)
#2023 16043 
#11046 16011 18184 30239 42822
day=$(date +%F)

#create loop for kernels to sim
for kernel in "${LGCN_kernels[@]}"; do
    #create params.in and append out parameter
    cp ../params/params_$config params.in
    echo "out ../stats/LGCN/$kernel" >> params.in
    echo "1" > trace_file_list
    echo "/home/cory/macsim/traces/LGCN/Kernel$kernel/trace.txt" >> trace_file_list
    echo "running macsim"
    echo "LGCN kernel $kernel" 
    echo "trace path /home/cory/macsim/traces/LGCN/Kernel$kernel/trace.txt"
    mkdir ../stats/LGCN/$kernel
    mkdir ../stats/LGCN/$kernel/$day
    ./macsim 2>&1 | tee ../stats/LGCN/$kernel/$day/sim.log
done
