include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean jacobi-2d jacobi-2d.wasi jacobi-2d.em
lucet: jacobi-2d.lucet

jacobi-2d: jacobi-2d.c jacobi-2d.h
	${VERBOSE} ${CC} -o jacobi-2d jacobi-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

jacobi-2d.wasi: jacobi-2d.c jacobi-2d.h
	${WCC} -o jacobi-2d.wasi jacobi-2d.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

jacobi-2d.lucet: jacobi-2d.c jacobi-2d.h
	wasm32-wasi-clang -o jacobi-2d.lw jacobi-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o jacobi-2d.lucet jacobi-2d.lw

jacobi-2d.em: jacobi-2d.c jacobi-2d.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o jacobi-2d.em.js jacobi-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f jacobi-2d jacobi-2d.wasi jacobi-2d.l* jacobi-2d.em.*

