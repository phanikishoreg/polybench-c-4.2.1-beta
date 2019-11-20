include ../../../config.mk

EXTRA_FLAGS=-lm

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean gramschmidt gramschmidt.wasi gramschmidt.em
lucet:  gramschmidt.lucet
native:gramschmidt
wasi:gramschmidt.wasi
node:gramschmidt.em

gramschmidt: gramschmidt.c gramschmidt.h
	${VERBOSE} ${CC} -o gramschmidt gramschmidt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

gramschmidt.wasi: gramschmidt.c gramschmidt.h
	${WCC} -o gramschmidt.wasi gramschmidt.c ${CFLAGS} ${WCFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto

gramschmidt.lucet: gramschmidt.c gramschmidt.h
	wasm32-wasi-clang -o gramschmidt.lw gramschmidt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o gramschmidt.lucet gramschmidt.lw

gramschmidt.em: gramschmidt.c gramschmidt.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o gramschmidt.em.js gramschmidt.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f gramschmidt gramschmidt.wasi gramschmidt.l* gramschmidt.em.*

