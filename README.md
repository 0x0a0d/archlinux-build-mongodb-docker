# archlinux-build-mongodb-docker

Install by using this script
```bash
tar xzf mongodb-arch-r6.0.9.tar.gz
```
 move to unpacked folder
```bash
#!/bin/bash
# change it to install location, default is
pkgdir=
srcdir=`pwd`
_pkgname=mongodb
pkgver=6.0.9

cd "${srcdir}/${_pkgname}-src-r${pkgver}"

# Install binaries
install -D ./usr/bin/mongo "$pkgdir/usr/bin/mongo"
install -D ./usr/bin/mongod "$pkgdir/usr/bin/mongod"
install -D ./usr/bin/mongos "$pkgdir/usr/bin/mongos"

# Keep historical Arch conf file name
install -Dm644 ./etc/${_pkgname}.conf "$pkgdir/etc/${_pkgname}.conf"

# Keep historical Arch service name
install -Dm644 ./usr/lib/systemd/system/${_pkgname}.service "$pkgdir/usr/lib/systemd/system/${_pkgname}.service"

# Install manpages
#install -Dm644 ./usr/share/man/man1/mongo.1 "$pkgdir/usr/share/man/man1/mongo.1"
install -Dm644 ./usr/share/man/man1/mongod.1 "$pkgdir/usr/share/man/man1/mongod.1"
install -Dm644 ./usr/share/man/man1/mongos.1 "$pkgdir/usr/share/man/man1/mongos.1"

# Install systemd files
install -Dm644 ./usr/lib/sysusers.d/${_pkgname}.conf "$pkgdir/usr/lib/sysusers.d/${_pkgname}.conf"
install -Dm644 ./usr/lib/tmpfiles.d/${_pkgname}.conf "$pkgdir/usr/lib/tmpfiles.d/${_pkgname}.conf"

# Install license
install -D ./usr/share/licenses/mongodb/LICENSE "$pkgdir/usr/share/licenses/mongodb/LICENSE"
```
