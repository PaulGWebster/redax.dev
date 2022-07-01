#!/bin/bash

docker build -f Dockerfile.stage7 -t paulgwebster/perlbase:stage7 .         \
&& docker tag paulgwebster/perlbase:stage7 perlbase:stage7                  \
&& docker push paulgwebster/perlbase:stage7 || echo "Could not upload image"

echo "Extended perl libs installed"
