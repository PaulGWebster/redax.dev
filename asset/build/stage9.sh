#!/bin/bash

docker build -f Dockerfile.stage9 -t paulgwebster/perlbase:stage9 .        \
&& docker tag paulgwebster/perlbase:stage9 perlbase:stage9                \
&& docker push paulgwebster/perlbase:stage9 || echo "Could not upload image"

echo "User image created"