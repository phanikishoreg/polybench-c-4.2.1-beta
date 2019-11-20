include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean floyd-warshall floyd-warshall.wasi floyd-warshall.em
lucet: floyd-warshall.lucet
native:floyd-warshall
wasi:floyd-warshall.wasi
node:floyd-warshall.em

floyd-warshall: floyd-warshall.c floyd-warshall.h
	${VERBOSE} ${CC} -o floyd-warshall floyd-warshall.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

floyd-warshall.wasi: floyd-warshall.c floyd-warshall.h
	${WCC} -o floyd-warshall.wasi floyd-warshall.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

floyd-warshall.lucet: floyd-warshall.c floyd-warshall.h
	wasm32-wasi-clang -o floyd-warshall.lw floyd-warshall.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o floyd-warshall.lucet floyd-warshall.lw

floyd-warshall.em: floyd-warshall.c floyd-warshall.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o floyd-warshall.em.js floyd-warshall.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f floyd-warshall floyd-warshall.wasi floyd-warshall.l* floyd-warshall.em.*

