#!/bin/bash

docker build -f Dockerfile.stage5 -t perlbase:stage5 . \
&& echo "Backing service source image created, saving state" \
&& docker save -o stage5.dockerimg perlbase:stage5 \
&& echo "Written stage5.dockerimg" \
&& docker run perlbase:stage1 find / -name "*" > stage5.filelist
