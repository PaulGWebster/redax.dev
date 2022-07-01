#!/bin/bash

docker build -f Dockerfile.stage1 -t paulgwebster/perlbase:stage1 .         \
&& docker tag paulgwebster/perlbase:stage1 perlbase:stage1                  \
&& docker push paulgwebster/perlbase:stage1 || echo "Could not upload image"

echo "New base OS image created"
