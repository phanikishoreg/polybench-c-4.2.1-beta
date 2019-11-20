BASE_DIR=../../
include ../Makefile.inc

BENCH_DIR=.

BENCHES=adi  fdtd-2d  heat-3d  jacobi-1d  jacobi-2d  seidel-2d
BENCHESPLY=$(BENCHES:%=%_ply)

.PHONY: all clean polytests

polytests: $(BENCHESPLY) 

all: polytests
	@echo "Compilation done!"

clean:
	@rm -rf ${TMP_DIR}

%_ply:
	@mkdir -p ${TMP_DIR}
	@echo "Compiling $(@:%_ply=%)"
	${WASMCC} ${$(@:%_ply=%)_CFLAGS} ${WASMCFLAGS} ${OPTFLAGS} -I${POLYUTIL} ${POLYUTILC} ${DUMMY} ${BENCH_DIR}/$(@:%_ply=%)/*.c -o ${TMP_DIR}/$(@:%_ply=%).wasm
	${SFCC} ${TMP_DIR}/$(@:%_ply=%).wasm -o ${TMP_DIR}/$(@:%_ply=%).bc
	${CC} ${OPTFLAGS} -D${USE_MEM} ${TMP_DIR}/$(@:%_ply=%).bc ${MEMC} ${RT_LIBC} ${RT_RT} -o ${TMP_DIR}/$(@:%_ply=%)_wasm.out
	${CC} --shared -fPIC ${OPTFLAGS} -D${USE_MEM} -I${ART_INC} ${TMP_DIR}/$(@:%_ply=%).bc ${AMEMC} ${WASMISA} -o ${TMP_DIR}/$(@:%_ply=%)_wasm.aso
	@cp ${TMP_DIR}/$(@:%_ply=%)_wasm.aso ${ABIN_DIR}

