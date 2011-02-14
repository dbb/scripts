#!/usr/bin/perl
use autodie;
use strict;
use warnings;


# github.com/dbbolton

unless ( `which acpi` && `which cpufreq-set` ) {
    print "'acpi' or 'cpufrequtils' is not installed, exiting.\n";
    exit 1;
}

open(my $in, '<', '/proc/cpuinfo');
my $cores;

while ( <$in> ) {
    if ( /cpu\ cores.*(\d+)/ ) {
        $cores = $1;
    }
}

my $ac_status = `acpi -a`;
my $battery_status = `acpi -b`;
my $gov;

if ( $ac_status =~ /on-line/i ) {
    print "Running on AC power... using the performance governor\n";
    &set_gov( 'performance' );
}
elsif ($battery_status =~ /Discharging/ || $ac_status =~ /off-line/ ) {
    print "Running on Battery power... using the powersave governor\n";
    &set_gov( 'powersave' );
}
else {
    print "Power source unknown... using the ondemand governor\n";
    &set_gov( 'ondemand' );
}

sub set_gov {
    my ($gov) = @_;
    for my $core ( 0..($cores - 1) ) {
        print "Setting '$gov' for core '$core'...\n";
        system "cpufreq-set --cpu $core --governor $gov";
    }
}

print "cpu-gov is finished.\n";
exit 0;

