#!/bin/bash

BASHRC_PATH="$HOME/.bashrc"
SCRIPTS_PATH="$HOME/scripts"

if grep -Fxq "export PATH=$SCRIPTS_PATH:\$PATH" "$BASHRC_PATH" && \
   grep -Fxq "alias run_with_gpu='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'" "$BASHRC_PATH" && \
   grep -Fxq "alias make='make -j 6'" "$BASHRC_PATH"; then
    echo "Lines already present in $BASHRC_PATH. Nothing to do."
else
    echo "export PATH=$SCRIPTS_PATH:\$PATH" >> "$BASHRC_PATH"
    echo "alias run_with_gpu='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'" >> "$BASHRC_PATH"
    echo "alias make='make -j 6'" >> "$BASHRC_PATH"
    echo "Success"

    exec bash
fi

