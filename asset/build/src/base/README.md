# Split down raw base image

Created using: ``` docker export 4c36a441d8cd > base-gcc:12.1.0.raw ```

with 4c36a441d8cd originally being: gcc:12.1.0

And then the split files being created via: ```  split -b 40M base-gcc-12.1.0.raw ```

The base image can be restored with the following commands:

* cat x* > base-gcc-12.1.0.raw
* docker import base-gcc-12.1.0.raw perlbase:stage0

You should now be able to run the entire build chain
