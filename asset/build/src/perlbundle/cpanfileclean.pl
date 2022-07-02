#!/usr/bin/env perl

use v5.28;
use warnings;
use strict;

open(my $fh,'<','cpanfile');
while(<$fh>) { 
	my @q = split(/\s+/,$_);
	my ($pkg) = $q[1] =~ m/^.(.*)..$/; 
	say $pkg;
}
