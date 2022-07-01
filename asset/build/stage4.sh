#!/bin/bash

docker build -f Dockerfile.stage4 -t paulgwebster/perlbase:stage4 .         \
&& docker tag paulgwebster/perlbase:stage4 perlbase:stage4                  \
&& docker push paulgwebster/perlbase:stage4 || echo "Could not upload image"

echo "Database and supporting libs created"
