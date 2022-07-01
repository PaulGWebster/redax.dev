#!/bin/bash

docker build -f Dockerfile.stage8 -t paulgwebster/perlbase:release .        \
&& docker tag paulgwebster/perlbase:release perlbase:release                \
&& docker push paulgwebster/perlbase:release || echo "Could not upload image"

echo "Final image created"
