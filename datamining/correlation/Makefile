include ../../config.mk

EXTRA_FLAGS=-lm
WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all:clean correlation correlation.wasi correlation.em
lucet: correlation.lucet

correlation: correlation.c correlation.h
	${VERBOSE} ${CC} -o correlation correlation.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}


correlation.wasi: correlation.c correlation.h
	${WCC} -o correlation.wasi correlation.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

correlation.lucet: correlation.c correlation.h
	wasm32-wasi-clang -o correlation.lw correlation.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o correlation.lucet correlation.lw

correlation.em: correlation.c correlation.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o correlation.em.js correlation.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}


clean:
	@ rm -f correlation correlation.wasi correlation.l* correlation.em.*

