#!/bin/bash

origin=$(pwd)

cd src/base \
&& echo "Importing stage0 ..." \
&& cat x* > base-gcc-12.1.0.raw \
&& docker import base-gcc-12.1.0.raw perlbase:stage0 \
&& echo "Imported perlbase:stage0, saving state" \
&& cd "$origin" \
&& docker save -o stage0.dockerimg perlbase:stage0 \
&& echo "Written stage0.dockerimg" \
&& docker run perlbase:stage1 find / -name "*" > stage0.filelist
