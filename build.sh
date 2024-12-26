#!/bin/bash

pacman -Sy --needed --noconfirm git glibc docker docker-compose
git clone https://aur.archlinux.org/mongodb.git
chown -R nobody:nobody mongodb

cat > Dockerfile << EOF
FROM archlinux:base

RUN pacman-key --init && \
    pacman -Sy --noconfirm archlinux-keyring && \
    pacman -Sy --needed --noconfirm boost-libs curl libstemmer pcre snappy yaml-cpp boost \
        python-cheetah3 python-psutil python-pymongo python-regex python-requests python-setuptools python-yaml \
        git glibc patch binutils fakeroot sudo clang mongo-c-driver gperftools libunwind \
        pkgconf

USER nobody
WORKDIR /mongodb
RUN makepkg
EOF

docker build -t mongodb-builder .
nproc=$(nproc)
result=$(awk "BEGIN {printf \"%.1f\", 0.95 * $nproc}")
docker run -v `pwd`/mongodb:/mongodb --cpus=$result mongodb-builder
if [[ $? -eq 0 ]]; then
    echo "***************"
    echo "*   SUCCESS   *"
    echo "***************"
    echo ""
    echo "To install do:"
    echo "
move mongodb /
cd /mongodb
source PKGBUILD
srcdir=\`pwd\`/src
package && \\
docker rmi mongodb-builder && \\
rm ./Dockerfile
pacman -Sy --needed --noconfirm boost-libs curl libstemmer pcre snappy yaml-cpp glibc
"
else
    echo Build failed
fi
