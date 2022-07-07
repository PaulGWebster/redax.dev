#!/usr/bin/env perl

use v5.28;

use warnings;
use strict;

my $installed = `apt list --installed`;

my @lines = split(/\n/, $installed);
my @packages;

foreach my $line (@lines) {
        if ($line =~ m#installed#) {
                my ($pkg) = $line =~ m/^(.*?)\//;
                push @packages,$pkg;
        }
}

say 'Packages detected: '.scalar(@packages);

foreach my $pkg_name (@packages) {
        say "Attempting to remove: $pkg_name";
        my $remove = `apt remove $pkg_name -y 2>/dev/null`;
        my ($result) =  $remove =~ m/(\d+) to remove and \d+ not upgraded/m;
        if (!$result) { $result = 0 }
        say "To be removed: $result";
}
