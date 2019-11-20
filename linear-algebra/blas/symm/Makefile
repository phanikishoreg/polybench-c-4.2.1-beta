include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean symm symm.wasi symm.em
lucet: symm.lucet
native:symm
wasi:symm.wasi
node:symm.em

symm: symm.c symm.h
	${VERBOSE} ${CC} -o symm symm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

symm.wasi: symm.c symm.h
	${WCC} -o symm.wasi symm.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

symm.lucet: symm.c symm.h
	wasm32-wasi-clang -o symm.lw symm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o symm.lucet symm.lw

symm.em: symm.c symm.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o symm.em.js symm.c -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f symm symm.wasi symm.l* symm.em.*

