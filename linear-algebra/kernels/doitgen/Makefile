include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean doitgen doitgen.wasi doitgen.em
lucet: doitgen.lucet

doitgen: doitgen.c doitgen.h
	${VERBOSE} ${CC} -o doitgen doitgen.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

doitgen.wasi: doitgen.c doitgen.h
	${WCC} -o doitgen.wasi doitgen.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

doitgen.lucet: doitgen.c doitgen.h
	wasm32-wasi-clang -o doitgen.lw doitgen.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o doitgen.lucet doitgen.lw


doitgen.em: doitgen.c doitgen.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o doitgen.em.js doitgen.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f doitgen doitgen.wasi doitgen.l* doitgen.em.*

