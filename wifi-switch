#!/usr/bin/env perl
use strict;
use warnings;

use autodie;
use File::Copy;

# Options #######################################
my $file           = "interfaces";

my $primary_id     = 'wpa-ssid primid';
my $primary_pass   = 'wpa-psk  primpass';

my $secondary_id   = 'wpa-ssid secid';
my $secondary_pass = 'wpa-psk  secpass';

# End Options ###################################

open( my $in, "<",  $file );
open( my $out, ">",  "$file.tmp" );

my $target = $ARGV[0]
    or die "Must supply '1' or '2' as the target network.\n";

if ( $target == 1 ) {
    &set_primary();
}
elsif ( $target == 2 ) {
    &set_secondary();
}
else {
    print "Invalid network selection.\n";
}


sub set_primary {
    while ( <$in> ) {
        s/$secondary_id/$primary_id/;
        s/$secondary_pass/$primary_id/;
        print $out $_;
    }
} # end &set_primary

sub set_secondary {
    while ( <$in> ) {
        s/$primary_id/$secondary_id/;
        s/$primary_pass/$secondary_id/;
        print $out $_;
    }
} # end &set_secondary

move( $file, "$file.orig" );
move( "$file.tmp", $file );

close $in;
close $out;
