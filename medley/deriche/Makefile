include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean deriche deriche.wasi deriche.em
lucet: deriche.lucet
native:deriche
wasi:deriche.wasi
node:deriche.em

deriche: deriche.c deriche.h
	${VERBOSE} ${CC} -o deriche deriche.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

deriche.wasi: deriche.c deriche.h
	${WCC} -o deriche.wasi deriche.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

deriche.lucet: deriche.c deriche.h
	wasm32-wasi-clang -o deriche.lw deriche.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o deriche.lucet deriche.lw

deriche.em: deriche.c deriche.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o deriche.em.js deriche.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f deriche deriche.wasi deriche.l* deriche.em.*

