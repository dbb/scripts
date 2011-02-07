#!/usr/bin/env perl 
use autodie;
use Date::Format;
use strict;
use warnings;

# github.com/dbbolton

while (1) {
    my $status = &load . ' | ' . &freem . ' MB | ' . &clock;

    # where the text is printed
    system "xsetroot -name \"$status\"" ;

    # this is used for testing in the console
    # you might want to comment out the infinite loop's start and end
    # as well
    # print $status;
    
    # update interval
    system "sleep 5s";

} # end infinite loop

# Current Load ############################################################
sub load {
    chop( my $load = (split ' ', `uptime`)[-2] );
    return $load;
}
# Active Memory ###########################################################
sub act_mem {
    my $memmb = 0;

    open(my $meminfo,  "<",  "/proc/meminfo");

    while ( <$meminfo> ) {
        if ( /^Active:/ ) {
            my $memkb = ( split(/ /, $_) )[-2];
            $memmb = sprintf( "%.0f", ($memkb/1024) );
            return $memmb;
        } # end if
    } # end while
} # end &act_mem

# Used mem from `free -m` #################################################
sub freem {
    my @lines = split /\n/, `free -m`;

    for ( @lines ) {
        if ( /cache:/ ) {
           my $used = (split /\s+/, $_)[2];
           return $used;
       } # end if
    } # end for
} # end &freem


# Time #####################################################################
sub clock {
    my $time = time2str( "%R", time );
    return $time;
}

