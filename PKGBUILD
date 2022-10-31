# Maintainer: Saphira Kai
pkgname=eventsfx
pkgver=0
pkgrel=1
epoch=
pkgdesc="A lightweight daemon for adding UI interaction sounds on input events"
arch=(any)
url="<none>"
license=('MIT')
groups=()
depends=(bash libinput)
makedepends=(rust cargo tar gzip)
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=

pkgver() {
	(
		set -o pipefail
		git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
		printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
	)
}

source=("src-$(pkgver).tar")
noextract=()
sha256sums=('SKIP')
validpgpkeys=()

#prepare() {}

#build() {}

#check() {}

package() {
	cd "$srcdir"
	
	cargo build --release
	
	install -Dm 755 audio/ $pkgdir/usr/share/eventsfx/audio/
	install -Dm 755 target/release/eventsfx $pkgdir/usr/bin/eventsfx
}
