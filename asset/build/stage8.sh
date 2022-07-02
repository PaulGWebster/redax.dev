#!/bin/bash

docker build -f Dockerfile.stage8 -t paulgwebster/perlbase:stage8 .         \
&& docker tag paulgwebster/perlbase:stage8 perlbase:stage8                  \
&& docker push paulgwebster/perlbase:stage8 || echo "Could not upload image"

echo "Pre user level instance created"
