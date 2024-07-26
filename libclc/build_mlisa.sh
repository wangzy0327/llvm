#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
mkdir -p $SCRIPT_PATH/build && cd $SCRIPT_PATH/build
PARENT_DIR=$(dirname "$SCRIPT_PATH")
echo "parent dir $PARENT_DIR -j30"
cmake -DLIBCLC_TARGETS_TO_BUILD=mlisa-- -DCMAKE_LLAsm_COMPILER_FORCED=True -DLLVM_CMAKE_PATH="$PARENT_DIR/build/lib/cmake/llvm" -DCLANG_CMAKE_PATH="$PARENT_DIR/build/lib/cmake/clang" ..
make -j$(nproc)
mv lib/clc/libspirv-mlisa--.bc ../../build/lib/clc/libspirv-mlisa--.bc
