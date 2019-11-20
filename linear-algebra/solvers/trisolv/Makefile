include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean trisolv trisolv.wasi trisolv.em
lucet: trisolv.lucet

trisolv: trisolv.c trisolv.h
	${VERBOSE} ${CC} -o trisolv trisolv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

trisolv.wasi: trisolv.c trisolv.h
	${WCC} -o trisolv.wasi trisolv.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

trisolv.lucet: trisolv.c trisolv.h
	wasm32-wasi-clang -o trisolv.lw trisolv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o trisolv.lucet trisolv.lw

trisolv.em: trisolv.c trisolv.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o trisolv.em.js trisolv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f trisolv trisolv.wasi trisolv.l* trisolv.em.*

