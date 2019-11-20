include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean bicg bicg.wasi bicg.em
lucet: bicg.lucet
native:bicg
wasi:bicg.wasi
node:bicg.em

bicg: bicg.c bicg.h
	${VERBOSE} ${CC} -o bicg bicg.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

bicg.wasi: bicg.c bicg.h
	${WCC} -o bicg.wasi bicg.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

bicg.lucet: bicg.c bicg.h
	wasm32-wasi-clang -o bicg.lw bicg.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o bicg.lucet bicg.lw

bicg.em: bicg.c bicg.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o bicg.em.js bicg.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f bicg bicg.wasi bicg.l* bicg.em.*

