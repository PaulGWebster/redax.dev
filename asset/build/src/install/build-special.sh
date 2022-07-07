#!/bin/bash

targetpkg="$1"
cdir=$(pwd)
srcdir="${targetpkg}-src"
tprefix="/usr"
stype=""

if [[ -n "$2" ]];
    then
        stype="$2"
        echo "Special build selected: ${stype}"
    else
        echo "Cannot continue without 3rd argument!"
        exit 1
fi

cd "$cdir"
pkgnamefind=$(find . -maxdepth 1 -type f -name "${targetpkg}*.tar.*")
if [[ -n ${pkgnamefind} ]];
    then
        echo -n ""
    else 
        pkgnamefind=$(find . -maxdepth 1 -type f -name "${targetpkg}*.tgz")
fi
pkgname=${pkgnamefind:2}

if [[ -n $pkgname ]];
    then
        echo "Preparing to install $targetpkg ($cdir), tarbell: $pkgname"
    else
        echo "Failed to find associated tarbell for ${targetpkg}!" && exit 1
fi

if [[ -n ${CARGS} ]];
    then
        echo "Additional configure args: ${CARGS}"
    else
        CARGS=""
fi

if [[ -n ${PREFIX} ]];
    then
        tprefix=${PREFIX}
fi

echo "Prefix target: ${tprefix}"
sleep 2

mkdir -p "${srcdir}" \
&& rm -Rf "${srcdir}" \
&& mkdir "${srcdir}" \
&& tar -xf "${pkgname}" -C "${srcdir}" \
&& cd "${srcdir}" \
&& cd $(ls)

berror=1

if [[ $stype == "tcl" ]];
    then
        cd unix \
        && ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && make install \
        && make clean \
        && cd "$cdir" \
        && rm -Rf "${srcdir}" \
        && rm "${pkgname}" \
        && berror=0
elif [[ $stype == "lz4" ]];
    then
        find /usr -name '*lz4*' -exec rm -r '{}' \; || true
        find /usr -name '*lz4*' -exec unlink '{}' \; || true
        make -j4 || berror = 1

        dpkg \
            --remove \
            --force-remove-essential \
            --ignore-depends=libsystemd0,libsystemd0 \
        liblz4-1 \

        make install clean \
        && rm -Rf /asset/lz4* \
        && berror=0
elif [[ $stype == "tar" ]];
    then
        export FORCE_UNSAFE_CONFIGURE=1
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
            --ignore-depends=dpkg,dpkg-dev \
        tar \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/tar*
elif [[ $stype == "autoconf" ]];
    then
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
            --ignore-depends=automake \
        autoconf \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/auto*
elif [[ $stype == "automake" ]];
    then
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
            --ignore-depends=libltdl-dev \
        automake \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/auto*
elif [[ $stype == "libtool" ]];
    then
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
        libtool \
        || echo "dpkg did not return success!"
    
        dpkg \
            --remove \
            --force-remove-essential \
        libltdl-dev \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/libtool*
elif [[ $stype == "make" ]];
    then
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
        make \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/make*
elif [[ $stype == "libidn2" ]];
    then
        ./configure --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
        libidn2 \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/libidn2*
elif [[ $stype == "perl" ]];
    then
        sh Configure \
            -de \
            -Dprefix=${tprefix} \
            -Doptimize="-O3 -pipe -fstack-protector -fno-strict-aliasing"   \
        && make -j4 \
        && berror=0

        dpkg \
            --remove \
            --force-remove-essential \
            --ignore-depends=liberror-perl,libdpkg-perl,git,dpkg-dev,autoconf \
        perl \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/perl*
elif [[ $stype == "cpanm" ]];
    then
        perl Makefile.PL -Dprefix=/usr \
        && make \
        && make install clean \
        && berror=0
        rm -Rf /asset/App*
elif [[ $stype == "libwww" ]];
    then
        perl Makefile.PL \
        && make \
        && make install clean \
        && berror=0
        rm -Rf /asset/libwww*
elif [[ $stype == "openssl" ]];
    then
        ./config --prefix=${tprefix} ${CARGS} \
        && make -j4 \
        && berror=0

        dpkg \
            --purge \
            --force-remove-essential \
            --ignore-depends=ca-certificates \
        openssl \
        || echo "dpkg did not return success!"

        make install clean || berror=1
        rm -Rf /asset/openssl*
elif [[ $stype == "zstd" ]];
    then
        make -j4 \
        && berror=0

        # dpkg \
        #     --remove \
        #     --force-remove-essential \
        #     --ignore-depends=libsystemd0,libapt-pkg6.0,gcc-10,g++-10,cpp-10 \
        # libzstd1 \
        # || echo "dpkg did not return success!"

        make install clean \
        || berror=1
        rm -Rf /asset/zstd*
elif [[ $stype == "meson" ]];
    then
        python3 -m pip install meson && berror=0
        rm -Rf /asset/meson*
elif [[ $stype == "ncurses" ]];
    then
        mkdir build
        pushd build
            ../configure
            make -C include
            make -C progs tic
        popd

        ./configure --prefix=/usr       \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-debug              \
            --enable-widec

        make -j4 || berror=1
        make install clean && berror=0

        rm -Rf /asset/ncurses*
else
    echo "Called to else on special install!"
    berror=1
fi

exit ${berror}



