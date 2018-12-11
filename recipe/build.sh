#!/bin/bash

if [[ ${CC} =~ .*gcc.* && ${c_compiler} =~ .*toolchain.* ]]; then
    export CFLAGS="${CFLAGS} -std=c99 "
fi

# Building with conda-forge gmp causes a strange segfault.  
# Using mini-gmp seems to solve the issue and gnutls still works
./configure --prefix="${PREFIX}" \
    --libdir="${PREFIX}/lib/" \
    --with-lib-path="${PREFIX}/lib/" \
    --enable-mini-gmp || { cat config.log; exit 1; }
make
make install
make check

