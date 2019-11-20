include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean trmm trmm.wasi trmm.em
lucet: trmm.lucet

trmm: trmm.c trmm.h
	${VERBOSE} ${CC} -o trmm trmm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

trmm.wasi: trmm.c trmm.h
	${WCC} -o trmm.wasi trmm.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

trmm.lucet: trmm.c trmm.h
	wasm32-wasi-clang -o trmm.lw trmm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o trmm.lucet trmm.lw

trmm.em: trmm.c trmm.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o trmm.em.js trmm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f trmm trmm.wasi trmm.l* trmm.em.*

