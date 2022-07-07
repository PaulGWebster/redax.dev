#!/bin/bash

# Convince docker that the newly built stage2 is really stage1
# and then re-run stage2 to recompile ontop of the existing image
# to ensure lib-linkage

echo "Copying stage2 dockerfile to stage3"
cp -v Dockerfile.stage2 Dockerfile.stage3
echo "Modifying copy"
sed -i 's/FROM perlbase:stage1 AS stage2/FROM perlbase:stage2 AS stage3/' Dockerfile.stage3
#cat Dockerfile.tmp | perl -ne 'my $line = $_; $line =~ s/stage\d-step(\d)/stage3-step$1/g; print $line' > Dockerfile.stage3

docker build --no-cache -f Dockerfile.stage3 -t perlbase:stage3 . \
&& echo "New OS Lib image created, saving state" \
&& docker save -o stage3.dockerimg perlbase:stage3 \
&& echo "Written stage3.dockerimg" \
&& docker run perlbase:stage1 find / -name "*" > stage3.filelist

