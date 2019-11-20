include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean 2mm 2mm.wasi 2mm.em
lucet: 2mm.lucet

2mm: 2mm.c 2mm.h
	${VERBOSE} ${CC} -o 2mm 2mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

2mm.wasi: 2mm.c 2mm.h
	${WCC} -o 2mm.wasi 2mm.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

2mm.lucet: 2mm.c 2mm.h
	wasm32-wasi-clang -o 2mm.lw 2mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o 2mm.lucet 2mm.lw

2mm.em: 2mm.c 2mm.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o 2mm.em.js 2mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f 2mm 2mm.wasi 2mm.l* 2mm.em.*

