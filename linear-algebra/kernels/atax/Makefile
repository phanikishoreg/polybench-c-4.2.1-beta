include ../../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean atax atax.wasi atax.em
lucet: atax.lucet

atax: atax.c atax.h
	${VERBOSE} ${CC} -o atax atax.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

atax.wasi: atax.c atax.h
	${WCC} -o atax.wasi atax.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

atax.lucet: atax.c atax.h
	wasm32-wasi-clang -o atax.lw atax.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o atax.lucet atax.lw

atax.em: atax.c atax.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o atax.em.js atax.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f atax atax.wasi atax.l* atax.em.*

