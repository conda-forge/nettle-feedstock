#!/bin/bash

if [[ ${CC} =~ .*gcc.* && ${c_compiler} =~ .*toolchain.* ]]; then
    export CFLAGS="${CFLAGS} -std=c99 "
fi
# See: https://gitlab.com/gnutls/gnutls/issues/665
export CPPFLAGS="${CPPFLAGS//-DNDEBUG/}"

./configure --prefix="${PREFIX}"              \
            --libdir="${PREFIX}/lib/"         \
            --with-lib-path="${PREFIX}/lib/"  \
            --enable-mini-gmp || { cat config.log; exit 1; }
make -j${CPU_COUNT} ${VERBOSE_AT}
make install ${VERBOSE_AT}
make check
