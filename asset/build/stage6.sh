#!/bin/bash

cp -R /home/paul.webster/personal/p5-Author-Daemon-DockerMetaBundle ./perlbundle

docker build -f Dockerfile.stage6 -t paulgwebster/perlbase:stage6 .         \
&& docker tag paulgwebster/perlbase:stage6 perlbase:stage6                  \
&& docker push paulgwebster/perlbase:stage6 || echo "Could not upload image"

rm -Rf p5-Author-Daemon-DockerMetaBundle

echo "Common perl libs installed"
