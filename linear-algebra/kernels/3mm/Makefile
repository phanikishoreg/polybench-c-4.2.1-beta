include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean 3mm 3mm.wasi 3mm.em
lucet: 3mm.lucet

3mm: 3mm.c 3mm.h
	${VERBOSE} ${CC} -o 3mm 3mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

3mm.wasi: 3mm.c 3mm.h
	${WCC} -o 3mm.wasi 3mm.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

3mm.lucet: 3mm.c 3mm.h
	wasm32-wasi-clang -o 3mm.lw 3mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o 3mm.lucet 3mm.lw

3mm.em: 3mm.c 3mm.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o 3mm.em.js 3mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f 3mm 3mm.wasi 3mm.l* 3mm.em.*

