include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean gemm gemm.wasi gemm.em
lucet: gemm.lucet
native:gemm
wasi:gemm.wasi
node:gemm.em

gemm: gemm.c gemm.h
	${VERBOSE} ${CC} -o gemm gemm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

gemm.wasi: gemm.c gemm.h
	${WCC} -o gemm.wasi gemm.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

gemm.lucet: gemm.c gemm.h
	wasm32-wasi-clang -o gemm.lw gemm.c -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o gemm.lucet gemm.lw

gemm.em: gemm.c gemm.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o gemm.em.js gemm.c -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f gemm gemm.wasi gemm.l* gemm.em.*

