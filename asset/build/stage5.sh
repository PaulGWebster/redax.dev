#!/bin/bash

docker build -f Dockerfile.stage5 -t paulgwebster/perlbase:stage5 .         \
&& docker tag paulgwebster/perlbase:stage5 perlbase:stage5                  \
&& docker push paulgwebster/perlbase:stage5 || echo "Could not upload image"

echo "Image flatenning complete"
