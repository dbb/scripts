#!/usr/bin/perl
use autodie;
use Date::Format;
use strict;
use warnings;

# github.com/dbbolton

while (1) {
# Current Load #############################################################
chop( my $load = (split ' ', `uptime`)[-2] );

# Active Memory ############################################################
my $memmb = 0;
open(my $meminfo,  "<",  "/proc/meminfo");
while ( <$meminfo> ) {
    if ( /^Active:/ ) {
        my $memkb = ( split(/ /, $_) )[-2];
        $memmb = sprintf( "%.0f", ($memkb/1024) );
    }
}

# Time #####################################################################
my $zeit = time2str( "%R", time );

# All together now #########################################################
my $status = "$load | $memmb MB | $zeit ";

system "xsetroot -name \"$status\"" ;
system "sleep 5s";

} # end infinite loop

