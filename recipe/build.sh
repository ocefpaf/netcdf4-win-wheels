#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    export LDFLAGS="-headerpad_max_install_names ${LDFLAGS}"
fi

export netCDF4_DIR="${PREFIX}"
export HDF5_DIR="${PREFIX}"

${PYTHON} -m pip wheel . --wheel-dir=dist --no-deps --no-build-isolation -vv

# ${PYTHON} -m pip install --no-deps --ignore-installed .
