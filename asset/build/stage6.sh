#!/bin/bash

docker build -f Dockerfile.stage6 -t perlbase:stage6 . \
&& echo "Backing service source image created, saving state" \
&& docker save -o stage6.dockerimg perlbase:stage6 \
&& echo "Written stage6.dockerimg" \
&& docker run perlbase:stage1 find / -name "*" > stage6.filelist
