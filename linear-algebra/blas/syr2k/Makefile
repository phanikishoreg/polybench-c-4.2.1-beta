include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean syr2k syr2k.wasi syr2k.em
lucet: syr2k.lucet

syr2k: syr2k.c syr2k.h
	${VERBOSE} ${CC} -o syr2k syr2k.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

syr2k.wasi: syr2k.c syr2k.h
	${WCC} -o syr2k.wasi syr2k.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

syr2k.lucet: syr2k.c syr2k.h
	wasm32-wasi-clang -o syr2k.lw syr2k.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o syr2k.lucet syr2k.lw

syr2k.em: syr2k.c syr2k.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o syr2k.em.js syr2k.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f syr2k syr2k.wasi syr2k.l* syr2k.em.*

