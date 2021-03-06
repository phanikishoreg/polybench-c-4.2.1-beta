sf_dir=datamining linear-algebra/blas linear-algebra/kernels linear-algebra/solvers medley stencils
oth_dir=datamining/correlation datamining/covariance linear-algebra/blas/gemm linear-algebra/blas/gemver linear-algebra/blas/gesummv linear-algebra/blas/symm linear-algebra/blas/syr2k linear-algebra/blas/syrk linear-algebra/blas/trmm linear-algebra/kernels/2mm linear-algebra/kernels/3mm linear-algebra/kernels/atax linear-algebra/kernels/bicg linear-algebra/kernels/doitgen linear-algebra/kernels/mvt linear-algebra/solvers/cholesky linear-algebra/solvers/durbin linear-algebra/solvers/gramschmidt linear-algebra/solvers/lu linear-algebra/solvers/ludcmp linear-algebra/solvers/trisolv medley/deriche medley/floyd-warshall medley/nussinov stencils/adi stencils/fdtd-2d stencils/heat-3d stencils/jacobi-1d stencils/jacobi-2d stencils/seidel-2d

clean:
	@ for dir in ${sf_dir} ; do \
		make -C $$dir clean ; \
	done
	@ for dir in ${oth_dir} ; do \
		make -C $$dir clean ; \
	done

native:
	@ for dir in ${oth_dir} ; do \
		make -C $$dir native ; \
	done

wavm: wasi

wasmer: wasi

wasi:
	@ for dir in ${oth_dir} ; do \
		make -C $$dir wasi ; \
	done

lucet:
	@ for dir in ${oth_dir} ; do \
		make -C $$dir lucet ; \
	done

node:
	@ for dir in ${oth_dir} ; do \
		make -C $$dir node ; \
	done

awsm:
	@ for dir in ${sf_dir} ; do \
		make -C $$dir awsm ; \
	done

sf:
	@ for dir in ${sf_dir} ; do \
		make -C $$dir sf ; \
	done

