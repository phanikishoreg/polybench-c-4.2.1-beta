include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean lu lu.wasi lu.em
lucet: lu.lucet
native:lu
wasi:lu.wasi
node:lu.em

lu: lu.c lu.h
	${VERBOSE} ${CC} -o lu lu.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

lu.wasi: lu.c lu.h
	${WCC} -o lu.wasi lu.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

lu.lucet: lu.c lu.h
	wasm32-wasi-clang -o lu.lw lu.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o lu.lucet lu.lw

lu.em: lu.c lu.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o lu.em.js lu.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f lu lu.wasi lu.l* lu.em.*

