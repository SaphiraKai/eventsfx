#!/bin/bash

#? Set safe bash options
set -euo pipefail
IFS=$'\n'

version=$(git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")

files=('audio/'
       'src/'
       'Cargo.toml'
       'eventsfx.service')

tar -cf pkgbuild/src-$version.tar ${files[@]}

echo "created pkgbuild/src-$version.tar"
