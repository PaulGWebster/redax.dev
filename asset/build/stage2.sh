#!/bin/bash

docker build -f Dockerfile.stage2 -t paulgwebster/perlbase:stage2 .         \
&& docker tag paulgwebster/perlbase:stage2 perlbase:stage2                  \
&& docker push paulgwebster/perlbase:stage2 || echo "Could not upload image"

echo "New OS Lib image created"
