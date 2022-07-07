#!/bin/bash

docker build -f Dockerfile.stage1 -t perlbase:stage1 . \
&& echo "New base OS image created, saving state." \
&& docker save -o stage1.dockerimg perlbase:stage1 \
&& echo "Written stage1.dockerimg"  \
&& docker run perlbase:stage1 find / -name "*" > stage1.filelist
