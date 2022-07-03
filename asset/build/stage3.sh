#!/bin/bash

# Convince docker that the newly built stage2 is really stage1
# and then re-run stage2 to recompile ontop of the existing image
# to ensure lib-linkage

docker export perlbase:stage1 > stage1.tar \
&& docker rmi perlbase:stage1 \
&& docker tag perlbase:stage2 perlbase:stage1 \
&& docker build -f Dockerfile.stage2 -t paulgwebster/perlbase:stage3 .

docker push paulgwebster/perlbase:stage3 || echo "Could not upload image"

echo "Relinked OS lib image created"
