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
		bench=$(wasmer run $exe_relpath.wasi 2>/dev/null)
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
	testeach ./datamining/correlation/correlation
	testeach ./datamining/covariance/covariance
}

# medley
medley()
{
	testeach ./medley/deriche/deriche
	testeach ./medley/floyd-warshall/floyd-warshall
	testeach ./medley/nussinov/nussinov
}

# linear-algebra/blas
linear_algebra_blas()
{
	testeach ./linear-algebra/blas/gemm/gemm
	testeach ./linear-algebra/blas/gemver/gemver
	testeach ./linear-algebra/blas/gesummv/gesummv
	testeach ./linear-algebra/blas/symm/symm
	testeach ./linear-algebra/blas/syr2k/syr2k
	testeach ./linear-algebra/blas/syrk/syrk
	testeach ./linear-algebra/blas/trmm/trmm
}

# linear-algebra/kernels
linear_algebra_kernels()
{
	testeach ./linear-algebra/kernels/2mm/2mm
	testeach ./linear-algebra/kernels/3mm/3mm
	testeach ./linear-algebra/kernels/atax/atax
	testeach ./linear-algebra/kernels/bicg/bicg
	testeach ./linear-algebra/kernels/doitgen/doitgen
	testeach ./linear-algebra/kernels/mvt/mvt
}

# linear-algebra/solvers
linear_algebra_solvers()
{
	testeach ./linear-algebra/solvers/cholesky/cholesky
	testeach ./linear-algebra/solvers/durbin/durbin
	testeach ./linear-algebra/solvers/gramschmidt/gramschmidt
	testeach ./linear-algebra/solvers/lu/lu
	testeach ./linear-algebra/solvers/ludcmp/ludcmp
	testeach ./linear-algebra/solvers/trisolv/trisolv
}

# stencils
stencils()
{
	testeach ./stencils/adi/adi
	testeach ./stencils/fdtd-2d/fdtd-2d
	testeach ./stencils/heat-3d/heat-3d
	testeach ./stencils/jacobi-1d/jacobi-1d
	testeach ./stencils/jacobi-2d/jacobi-2d
	testeach ./stencils/seidel-2d/seidel-2d
}

datamining
medley
linear_algebra_blas
linear_algebra_kernels
linear_algebra_solvers
stencils
