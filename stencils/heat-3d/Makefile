include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean heat-3d heat-3d.wasi heat-3d.em
lucet: heat-3d.lucet

heat-3d: heat-3d.c heat-3d.h
	${VERBOSE} ${CC} -o heat-3d heat-3d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

heat-3d.wasi: heat-3d.c heat-3d.h
	${WCC} -o heat-3d.wasi heat-3d.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

heat-3d.lucet: heat-3d.c heat-3d.h
	wasm32-wasi-clang -o heat-3d.lw heat-3d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o heat-3d.lucet heat-3d.lw

heat-3d.em: heat-3d.c heat-3d.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o heat-3d.em.js heat-3d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f heat-3d heat-3d.wasi heat-3d.l* heat-3d.em.*

