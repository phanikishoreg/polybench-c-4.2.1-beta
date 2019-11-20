include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean mvt mvt.wasi mvt.em
lucet: mvt.lucet

mvt: mvt.c mvt.h
	${VERBOSE} ${CC} -o mvt mvt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

mvt.wasi: mvt.c mvt.h
	${WCC} -o mvt.wasi mvt.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

mvt.lucet: mvt.c mvt.h
	wasm32-wasi-clang -o mvt.lw mvt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o mvt.lucet mvt.lw

mvt.em: mvt.c mvt.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o mvt.em.js mvt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f mvt mvt.wasi mvt.l* mvt.em.*

