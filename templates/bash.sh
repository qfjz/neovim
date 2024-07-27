#!/usr/bin/env bash

KATALOG="$(dirname $(readlink -m $0))"
SKRYPT="$(basename $(readlink -m $0))"
# pełna ścieżka oraz nazwa pliku
FULL_FILE_NAME=$KATALOG/$SKRYPT

cd $KATALOG
