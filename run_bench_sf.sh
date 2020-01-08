#!/bin/bash

ITERS=$1

testeach()
{
	local exe_relpath=$1
	local total_runtime=0

	# Parse the binary name
	# Equivalent to https://regexr.com/4rrm3
	[[ $exe_relpath =~ /([^/]+)$ ]]
	bench_name="${BASH_REMATCH[1]}"

	for ((i=0; i < $ITERS; i++)); do
		start=$(date +%s.%N)
		bench=$($exe_relpath 2>/dev/null)
		end=$(date +%s.%N)
		runtime=$(echo "$end - $start" | bc)
		printf "%s, %d, %f\n" "$bench_name" "$i" "$runtime"
		total_runtime="$(echo "$total_runtime + $runtime" | bc)"
	done
	printf "%s, avg, %f\n" "$bench_name" "$(echo "scale=8;$total_runtime/$ITERS" | bc)"
}


# datamining
datamining()
{
	testeach ./datamining/tmp/correlation_wasm.out
	testeach ./datamining/tmp/covariance_wasm.out
}

# medley
medley()
{
	testeach ./medley/tmp/deriche_wasm.out
	testeach ./medley/tmp/floyd-warshall_wasm.out
	testeach ./medley/tmp/nussinov_wasm.out
}

# linear-algebra/blas
linear_algebra_blas()
{
	testeach ./linear-algebra/blas/tmp/gemm_wasm.out
	testeach ./linear-algebra/blas/tmp/gemver_wasm.out
	testeach ./linear-algebra/blas/tmp/gesummv_wasm.out
	testeach ./linear-algebra/blas/tmp/symm_wasm.out
	testeach ./linear-algebra/blas/tmp/syr2k_wasm.out
	testeach ./linear-algebra/blas/tmp/syrk_wasm.out
	testeach ./linear-algebra/blas/tmp/trmm_wasm.out
}

# linear-algebra/kernels
linear_algebra_kernels()
{
	testeach ./linear-algebra/kernels/tmp/2mm_wasm.out
	testeach ./linear-algebra/kernels/tmp/3mm_wasm.out
	testeach ./linear-algebra/kernels/tmp/atax_wasm.out
	testeach ./linear-algebra/kernels/tmp/bicg_wasm.out
	testeach ./linear-algebra/kernels/tmp/doitgen_wasm.out
	testeach ./linear-algebra/kernels/tmp/mvt_wasm.out
}

# linear-algebra/solvers
linear_algebra_solvers()
{
	testeach ./linear-algebra/solvers/tmp/cholesky_wasm.out
	testeach ./linear-algebra/solvers/tmp/durbin_wasm.out
	testeach ./linear-algebra/solvers/tmp/gramschmidt_wasm.out
	testeach ./linear-algebra/solvers/tmp/lu_wasm.out
	testeach ./linear-algebra/solvers/tmp/ludcmp_wasm.out
	testeach ./linear-algebra/solvers/tmp/trisolv_wasm.out
}

# stencils
stencils()
{
	testeach ./stencils/tmp/adi_wasm.out
	testeach ./stencils/tmp/fdtd-2d_wasm.out
	testeach ./stencils/tmp/heat-3d_wasm.out
	testeach ./stencils/tmp/jacobi-1d_wasm.out
	testeach ./stencils/tmp/jacobi-2d_wasm.out
	testeach ./stencils/tmp/seidel-2d_wasm.out
}

datamining
medley
linear_algebra_blas
linear_algebra_kernels
linear_algebra_solvers
stencils
