#!/usr/bin/env bash
config="A100"
workloads=('LightGCN-PyTorch' 'ExpressGNN')
workloads_short=('LGCN' 'EGNN')
LGCN_kernels=(2023 16043 16052)
#11046 16011 18184 30239 42822
EGNN_kernels=(66065 68290 71753)
#ALL KERNELS 
#28068 56324 66065 68290 71753 92417 107329

#create loop for kernels to sim
for i in {0..1}; do
    if [[ $i -eq 0 ]]; then
        for kernel in "${LGCN_kernels[@]}"; do
            #create params.in and append out parameter
            cp ../params/params_$config params.in
            echo "out ../stats/${workloads_short[$i]}/second/$kernel" >> params.in
            echo "1" > trace_file_list
            echo "/home/cory/${workloads[$i]}/traces/macsim-update/Kernel$kernel/trace.txt" >> trace_file_list
            echo "running macsim"
            echo "workload ${workloads[$i]}"
            echo "kernel $kernel" 
            echo "trace path /home/cory/${workloads[$i]}/traces/macsim-update/Kernel$kernel/trace.txt"
            mkdir ../stats/${workloads_short[$i]}/second/$kernel
            ./macsim 2>&1 | tee ../stats/${workloads_short[$i]}/second/$kernel/sim.log
        done
    elif [[ $i -eq 2 ]]; then
        for kernel in "${EGNN_kernels[@]}"; do
            #create params.in and append out parameter
            cp ../params/params_$config params.in
            echo "out ../stats/${workloads_short[$i]}/second/$kernel" >> params.in
            echo "1" > trace_file_list
            echo "/home/cory/${workloads[$i]}/traces/macsim-update/Kernel$kernel/trace.txt" >> trace_file_list
            echo "running macsim"
            echo "workload ${workloads[$i]}"
            echo "kernel $kernel" 
            echo "trace path /home/cory/${workloads[$i]}/traces/macsim-update/Kernel$kernel/trace.txt"
            ./macsim 2>&1 | tee ../stats/${workloads_short[$i]}/second/$kernel/sim.log
        done
    fi
done


#create trace_file_list using paths for each trace

#call ./macsim