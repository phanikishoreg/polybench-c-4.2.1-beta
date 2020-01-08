#!/bin/bash

iters=1

make clean
make native
./run_bench_native.sh $iters > native.csv
make wasi
./run_bench_wasmer.sh $iters > wasmer.csv
./run_bench_wavm.sh $iters > wavm.csv
make node
./run_bench_nodejs.sh $iters > nodejs.csv

# Note: Lucet needs to be run in the Lucet directory and silverfish needs to be run within the /silverfish 
# submodule of the Awsm container