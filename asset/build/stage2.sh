#!/bin/bash

docker build -f Dockerfile.stage2 -t perlbase:stage2 . \
&& echo "New OS Lib image created, saving state" \
&& docker save -o stage2.dockerimg perlbase:stage2 \
&& echo "Written stage2.dockerimg"