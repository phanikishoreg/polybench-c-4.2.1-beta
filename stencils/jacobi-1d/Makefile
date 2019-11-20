include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean jacobi-1d jacobi-1d.wasi jacobi-1d.em
lucet: jacobi-1d.lucet

jacobi-1d: jacobi-1d.c jacobi-1d.h
	${VERBOSE} ${CC} -o jacobi-1d jacobi-1d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

jacobi-1d.wasi: jacobi-1d.c jacobi-1d.h
	${WCC} -o jacobi-1d.wasi jacobi-1d.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

jacobi-1d.lucet: jacobi-1d.c jacobi-1d.h
	wasm32-wasi-clang -o jacobi-1d.lw jacobi-1d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o jacobi-1d.lucet jacobi-1d.lw

jacobi-1d.em: jacobi-1d.c jacobi-1d.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o jacobi-1d.em.js jacobi-1d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f jacobi-1d jacobi-1d.wasi jacobi-1d.l* jacobi-1d.em.*

