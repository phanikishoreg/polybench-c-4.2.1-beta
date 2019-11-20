include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean syrk syrk.wasi syrk.em
lucet: syrk.lucet
node:syrk
wasi:syrk.wasi
node:syrk.em

syrk: syrk.c syrk.h
	${VERBOSE} ${CC} -o syrk syrk.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

syrk.wasi: syrk.c syrk.h
	${WCC} -o syrk.wasi syrk.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

syrk.lucet: syrk.c syrk.h
	wasm32-wasi-clang -o syrk.lw syrk.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o syrk.lucet syrk.lw

syrk.em: syrk.c syrk.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o syrk.em.js syrk.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f syrk syrk.wasi syrk.l* syrk.em.*

