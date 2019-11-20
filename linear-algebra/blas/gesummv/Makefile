include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean gesummv gesummv.wasi gesummv.em
lucet: gesummv.lucet

gesummv: gesummv.c gesummv.h
	${VERBOSE} ${CC} -o gesummv gesummv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

gesummv.wasi: gesummv.c gesummv.h
	${WCC} -o gesummv.wasi gesummv.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

gesummv.lucet: gesummv.c gesummv.h
	wasm32-wasi-clang -o gesummv.lw gesummv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o gesummv.lucet gesummv.lw

gesummv.em: gesummv.c gesummv.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o gesummv.em.js gesummv.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f gesummv gesummv.wasi gesummv.l* gesummv.em.*

