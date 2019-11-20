include ../../../config.mk

EXTRA_FLAGS=-lm

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean cholesky cholesky.wasi cholesky.em
lucet: cholesky.lucet

cholesky: cholesky.c cholesky.h
	${VERBOSE} ${CC} -o cholesky cholesky.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

cholesky.wasi: cholesky.c cholesky.h
	${WCC} -o cholesky.wasi cholesky.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

cholesky.lucet: cholesky.c cholesky.h
	wasm32-wasi-clang -o cholesky.lw cholesky.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o cholesky.lucet cholesky.lw

cholesky.em: cholesky.c cholesky.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o cholesky.em.js cholesky.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f cholesky cholesky.wasi cholesky.l* cholesky.em.*

