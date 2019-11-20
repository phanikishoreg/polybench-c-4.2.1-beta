include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean seidel-2d seidel-2d.wasi seidel-2d.em
lucet: seidel-2d.lucet

seidel-2d: seidel-2d.c seidel-2d.h
	${VERBOSE} ${CC} -o seidel-2d seidel-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

seidel-2d.wasi: seidel-2d.c seidel-2d.h
	${WCC} -o seidel-2d.wasi seidel-2d.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

seidel-2d.lucet: seidel-2d.c seidel-2d.h
	wasm32-wasi-clang -o seidel-2d.lw seidel-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o seidel-2d.lucet seidel-2d.lw

seidel-2d.em: seidel-2d.c seidel-2d.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o seidel-2d.em.js seidel-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f seidel-2d seidel-2d.wasi seidel-2d.l* seidel-2d.em.*

