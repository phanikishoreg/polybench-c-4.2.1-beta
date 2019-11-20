include ../../config.mk

EXTRA_FLAGS=

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean adi adi.wasi adi.em
lucet: adi.lucet

adi: adi.c adi.h
	${VERBOSE} ${CC} -o adi adi.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

adi.wasi: adi.c adi.h
	${WCC} -o adi.wasi adi.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

adi.lucet: adi.c adi.h
	wasm32-wasi-clang -o adi.lw adi.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o adi.lucet adi.lw

adi.em: adi.c adi.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o adi.em.js adi.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f adi adi.wasi adi.l* adi.em.*

