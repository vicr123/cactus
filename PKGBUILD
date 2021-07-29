# Maintainer: Victor Tran <vicr12345 at gmail dot com>
pkgname=cactus-recovery-media
pkgver=20210702
pkgrel=1
pkgdesc="Recovery media for Cactus"
arch=("x86_64")
makedepends=('squashfs-tools')
url="https://vicr123.com/cactus"
license=('GPL3')
source=('rootfs.squashfs' 'rootfs.squashgs.sig')
sha256sums=('SKIP' 'SKIP')

#Don't compress this package because it's already been massively compressed
PKGEXT=.tar

pkgver() {
    date +%Y%m%d
}

package() {
    mkdir -p $pkgdir/opt/cactus-recovery-media/
    cp rootfs.squashfs $pkgdir/opt/cactus-recovery-media/rootfs.squashfs
    cp rootfs.squashfs.sig $pkgdir/opt/cactus-recovery-media/rootfs.squashfs.sig
}
