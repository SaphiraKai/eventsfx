#!/bin/bash

#? Set safe bash options
set -euo pipefail
IFS=$'\n'

version=$(git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")

files=('audio/'
       'src/'
       'Cargo.toml')

tar -cf src-$version.tar ${files[@]}

echo "created src-$version.tar"
