#!/bin/bash

docker build -f Dockerfile.stage4 -t perlbase:stage4 . \
&& echo "Image crush complete, saving state" \
&& docker save -o stage4.dockerimg perlbase:stage4 \
&& echo "Written stage4.dockerimg" \
&& docker run perlbase:stage1 find / -name "*" > stage4.filelist
