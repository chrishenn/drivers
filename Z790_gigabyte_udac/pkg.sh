#!/bin/bash
set -euo pipefail
sdir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]:-$0}")")

src="$sdir/src"
dst="$sdir/drvr"

mkdir -p $dst

for exe in $(ls "$src"/*.exe); do
    echo "extracting: $exe"

    basename=${exe##*/}
    fname=${basename%.*}
    7z x $exe -o"$dst/$fname" &> /dev/null
done
