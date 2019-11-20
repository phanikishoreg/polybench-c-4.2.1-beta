include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean ludcmp ludcmp.wasi ludcmp.em
lucet: ludcmp.lucet
native:ludcmp
wasi:ludcmp.wasi
node:ludcmp.em

ludcmp: ludcmp.c ludcmp.h
	${VERBOSE} ${CC} -o ludcmp ludcmp.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

ludcmp.wasi: ludcmp.c ludcmp.h
	${WCC} -o ludcmp.wasi ludcmp.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

ludcmp.lucet: ludcmp.c ludcmp.h
	wasm32-wasi-clang -o ludcmp.lw ludcmp.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o ludcmp.lucet ludcmp.lw

ludcmp.em: ludcmp.c ludcmp.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o ludcmp.em.js ludcmp.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f ludcmp ludcmp.wasi ludcmp.l* ludcmp.em.*

