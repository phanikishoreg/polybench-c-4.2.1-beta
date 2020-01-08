BASE_DIR=../../
include ../Makefile.inc

BENCH_DIR=.

BENCHES=adi  fdtd-2d  heat-3d  jacobi-1d  jacobi-2d  seidel-2d
BENCHESPLY=$(BENCHES:%=%_ply)
BENCHESAPLY=$(BENCHES:%=%_aply)

.PHONY: all clean sf awsm

sf: $(BENCHESPLY)       
awsm: $(BENCHESAPLY)

all: sf awsm
	@echo "Compilation done!"

clean:
	@rm -rf ${TMP_DIR}

%_ply:
	@mkdir -p ${TMP_DIR}
	@echo "Compiling $(@:%_ply=%)"
	${WASMCC} ${$(@:%_ply=%)_CFLAGS} ${WASMCFLAGS} ${OPTFLAGS} -I${POLYUTIL} ${POLYUTILC} ${DUMMY} ${BENCH_DIR}/$(@:%_ply=%)/*.c -o ${TMP_DIR}/$(@:%_ply=%).wasm
	${SFCC} ${TMP_DIR}/$(@:%_ply=%).wasm -o ${TMP_DIR}/$(@:%_ply=%).bc
	${CC} ${OPTFLAGS} -D${USE_MEM} ${TMP_DIR}/$(@:%_ply=%).bc ${MEMC} ${RT_LIBC} ${RT_RT} -o ${TMP_DIR}/$(@:%_ply=%)_wasm.out
	${CC} ${OPTFLAGS} ${TMP_DIR}/$(@:%_ply=%).bc ${RT_MEM}/${MEMC_64} ${RT_LIBC} ${RT_RT} -o ${TMP_DIR}/$(@:%_ply=%)_wasm_vm.out
	${CC} ${OPTFLAGS} -D${USE_MEM} ${TMP_DIR}/$(@:%_ply=%).bc ${RT_MEM}/${MEMC_NO} ${RT_LIBC} ${RT_RT} -o ${TMP_DIR}/$(@:%_ply=%)_wasm_none.out

%_aply:
	@mkdir -p ${TMP_DIR}
	@echo "Compiling $(@:%_aply=%)"
	${WASMCC} ${$(@:%_aply=%)_CFLAGS} ${WASMCFLAGS} ${OPTFLAGS} -I${POLYUTIL} ${POLYUTILC} ${DUMMY} ${BENCH_DIR}/$(@:%_aply=%)/*.c -o ${TMP_DIR}/$(@:%_aply=%).wasm
	${SFCC} ${TMP_DIR}/$(@:%_aply=%).wasm -o ${TMP_DIR}/$(@:%_aply=%).bc
	${CC} --shared -fPIC ${OPTFLAGS} -D${USE_MEM} -I${ART_INC} ${TMP_DIR}/$(@:%_aply=%).bc ${AMEMC} ${WASMISA} -o ${TMP_DIR}/$(@:%_aply=%)_wasm.aso
	@cp ${TMP_DIR}/$(@:%_aply=%)_wasm.aso ${ABIN_DIR}

