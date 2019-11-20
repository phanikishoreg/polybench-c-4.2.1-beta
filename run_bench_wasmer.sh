#!/bin/sh

ITERS=$1

testeach()
{
        tmp_cnt=${ITERS}
	exe_relpath=$1

	echo "${exe_relpath} for ${tmp_cnt}"

        while [ ${tmp_cnt} -gt 0 ]; do
		start=$(date +%s.%N)
		bench=$(wasmer run $exe_relpath.wasi 2>/dev/null)
		end=$(date +%s.%N)
		tmp_cnt=$((tmp_cnt - 1))
		runtime=$(echo "$end - $start" | bc)
		echo "$bench $runtime"
        done

	echo "Done!"
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
