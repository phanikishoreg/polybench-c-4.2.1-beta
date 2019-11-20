include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean fdtd-2d fdtd-2d.wasi fdtd-2d.em
lucet: fdtd-2d.lucet

fdtd-2d: fdtd-2d.c fdtd-2d.h
	${VERBOSE} ${CC} -o fdtd-2d fdtd-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

fdtd-2d.wasi: fdtd-2d.c fdtd-2d.h
	${WCC} -o fdtd-2d.wasi fdtd-2d.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

fdtd-2d.lucet: fdtd-2d.c fdtd-2d.h
	wasm32-wasi-clang -o fdtd-2d.lw fdtd-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o fdtd-2d.lucet fdtd-2d.lw

fdtd-2d.em: fdtd-2d.c fdtd-2d.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o fdtd-2d.em.js fdtd-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f fdtd-2d fdtd-2d.wasi fdtd-2d.l* fdtd-2d.em.*

