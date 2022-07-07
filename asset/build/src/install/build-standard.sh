#!/bin/bash

targetpkg="$1"
cdir=$(pwd)
srcdir="${targetpkg}-src"
tprefix="/usr"

if [[ -n $2 ]];
        then
        cdir="$2"
                echo "Working directory argument passed, swapping to: ${cdir}."
        else
        echo "Working directory argument missing, using pwd: ${cdir}."
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
&& mkdir "${srcdir}"

tar -xf "${pkgname}" -C "${srcdir}" \
&& cd "${srcdir}" \
&& cd $(ls) \
&& ./configure --prefix=${tprefix} ${CARGS} \
&& make -j4 \
&& make install \
&& make clean \
&& cd "$cdir" \
&& rm -Rf "${srcdir}" \
&& rm "${pkgname}" \
&& exit 0
