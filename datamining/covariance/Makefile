include ../../config.mk

WCC=/opt/wasi-sdk/bin/clang
WSYSROOT=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS += --target=wasm32-wasi

all: clean covariance covariance.wasi covariance.em
lucet: covariance.lucet

covariance: covariance.c covariance.h
	${VERBOSE} ${CC} -o covariance covariance.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

covariance.wasi: covariance.c covariance.h
	${WCC} -o covariance.wasi covariance.c ${CFLAGS} ${WCFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS} -Wl,--allow-undefined,-z,stack-size=524288,--no-threads,--stack-first,--no-entry,--export-all,--export=main --sysroot=${WSYSROOT} -O3 -flto


covariance.lucet: covariance.c covariance.h
	wasm32-wasi-clang -o covariance.lw covariance.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}
	lucetc-wasi --reserved-size 4294967296 -o covariance.lucet covariance.lw

covariance.em: covariance.c covariance.h
	emcc -s ALLOW_MEMORY_GROWTH=1 -o covariance.em.js covariance.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

clean:
	@ rm -f covariance.wasi covariance covariance.l* covariance.em.*

