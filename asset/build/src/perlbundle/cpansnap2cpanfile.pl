#!/usr/bin/env perl

use v5.28;

use warnings;
use strict;

open(my $fh,'<','cpanfile.snapshot');
my @names;
while(<$fh>) {
	if ($_ =~ m/^\s\s([a-z0-9\-\.]+)/i) { push @names,$1 } 
}
foreach my $name (@names) {
	my ($pkg_name,$pkg_version) = $name =~ m/^(.*)\-(.*)$/;
	$pkg_name =~ s#-#::#g;
	if ($pkg_version !~ m/^[v0-9.]+$/) {
		say STDERR "Something is wrong with '$name' (name: $pkg_name, version: $pkg_version)";
        } else {
		say "requires '$pkg_name', '$pkg_version';";
	}
}
