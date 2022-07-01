#!/bin/bash

docker build -f Dockerfile.stage6 -t paulgwebster/perlbase:stage6 .         \
&& docker tag paulgwebster/perlbase:stage6 perlbase:stage6                  \
&& docker push paulgwebster/perlbase:stage6 || echo "Could not upload image"

echo "Common perl libs installed"
