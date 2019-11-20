include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean gemver gemver.wasi gemver.em
lucet: gemver.lucet
native:gemver
wasi:gemver.wasi
node:gemver.em

gemver: gemver.c gemver.h
	${VERBOSE} ${CC} -o gemver gemver.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

gemver.wasi: gemver.c gemver.h
	${WCC} -o gemver.wasi gemver.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

gemver.lucet: gemver.c gemver.h
	wasm32-wasi-clang -o gemver.lw gemver.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o gemver.lucet gemver.lw

gemver.em: gemver.c gemver.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o gemver.em.js gemver.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f gemver gemver.wasi gemver.l* gemver.em.*

