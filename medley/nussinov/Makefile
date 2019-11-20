include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean nussinov nussinov.wasi nussinov.em
lucet: nussinov.lucet
native:nussinov
wasi:nussinov.wasi
node:nussinov.em

nussinov: nussinov.c nussinov.h
	${VERBOSE} ${CC} -o nussinov nussinov.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

nussinov.wasi: nussinov.c nussinov.h
	${WCC} -o nussinov.wasi nussinov.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

nussinov.lucet: nussinov.c nussinov.h
	wasm32-wasi-clang -o nussinov.lw nussinov.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o nussinov.lucet nussinov.lw

nussinov.em: nussinov.c nussinov.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o nussinov.em.js nussinov.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f nussinov nussinov.wasi nussinov.l* nussinov.em.*

