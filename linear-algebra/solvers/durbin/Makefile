include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean durbin durbin.wasi durbin.em
lucet:  durbin.lucet

durbin: durbin.c durbin.h
	${VERBOSE} ${CC} -o durbin durbin.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

durbin.wasi: durbin.c durbin.h
	${WCC} -o durbin.wasi durbin.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

durbin.lucet: durbin.c durbin.h
	wasm32-wasi-clang -o durbin.lw durbin.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o  durbin.lucet durbin.lw

durbin.em: durbin.c durbin.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o durbin.em.js durbin.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f durbin durbin.wasi durbin.l* durbin.em.*

