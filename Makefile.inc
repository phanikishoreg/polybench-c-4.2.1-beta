BASE=awsm
SFCC=silverfish
CC=clang
WASMCC=wasm32-unknown-unknown-wasm-clang

OPTFLAGS=-O3 -flto -DPOLYBENCH_DUMP_ARRAYS -DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_TIME
#same stack-size for all
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--no-threads,--stack-first,--no-entry,--export-all,--export=main,--export=dummy
WASMCFLAGS=${WASMLINKFLAGS} -nostartfiles

RT_DIR=${BASE_DIR}/runtime/
RT_MEM=${RT_DIR}/memory/
#RT_INC=${RT_DIR}/include/
RT_LIBC=${RT_DIR}/libc/libc_backing.c
RT_RT=${RT_DIR}/runtime.c

DUMMY=${BASE_DIR}/code_benches/dummy.c

POLYUTIL=${BASE_DIR}/polybench-c-4.2.1-beta/utilities/
POLYUTILC=${POLYUTIL}/polybench.c

ABASE_DIR=${BASE_DIR}/../
ART_DIR=${ABASE_DIR}/runtime/
ART_INC=${ART_DIR}/include/

USE_MEM=USE_MEM_VM

ifeq ($(USE_MEM),USE_MEM_VM)
MEMC=${RT_MEM}/64bit_nix.c
AMEMC=${ART_DIR}/compiletime/memory/64bit_nix.c
endif
WASMISA=${ART_DIR}/compiletime/instr.c

ABIN_DIR=${ART_DIR}/bin/
TMP_DIR=tmp/
