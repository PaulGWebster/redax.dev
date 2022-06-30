# Stages

A note on numbering and naming, the entire process here is within stages, each stage has phases.

Almost no one should be interested in the earlier stages except for curiousity.

## Stage 1 - the one that did not exist

This image stack is based from the gcc dockerhub image, primarily to ensure glibc full compatability and compilation with the widest range of perl modules.

The first step was simply to docker pull gcc:12.1.0 and tag/push it as paulgwebster/gcc:12.1.0

This is the only non source built part of the image and at some point I will create a gzip/split of this stage.

Resultant image: perlbase:stage1

## Stage 2 (Dockerfile.gcc)

Dockerfile.gcc, this takes a saved gcc image and simply crushes into a single layer image the resultant for this will be tagged as perlbase:stage2

This stage also effectively removes all debian based package tools including apt python3 perl and even the debian-repository keyring, dpkg is also nuked in this procedure and realistically the entire image is as minimized as possible.

This step is better off likely skipped and using the uploaded version on dockerhub instead, which should be availible as: paulgwebster/perlbase:stage2

There is an exported version of this image that has been run through gzip and split https://www.man7.org/linux/man-pages/man1/split.1.html so that the resultant files will fit on github.

``` docker build . -f Dockerfile.gcc -t perlbase:stage2 ```

## Stage 3 (Dockerfile.db)

This stage adds in client libraries for sqlite, mssql, postgresql and maria

``` docker build . -f Dockerfile.lib -t perlbase:stage3 ```

## Stage 4 (Dockerfile.perl)

This one adds in the requierd modules for the previous steps as well as all the major frameworks, including POE Mojolicious Async and Catalyst

## Stage 5 (Dockerfile.misc)

Various bits that may need adjustments, presently blank

## Stage 6 (Dockerfile.clean)

The final pass cleaning unrequired files from the system before the final image publication.