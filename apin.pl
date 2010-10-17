#!/usr/bin/perl
use strict;
use warnings;

# github.com/dbbolton
#
# I use this script to install packages through aptitude as a normal user.

my $args     = '-P ';
my $packages = '';
my $pattern  = '';

for (@ARGV) {

    if ( /^-/ ) {
        $args .=  $_ . ' ';
    }
    elsif ( /^[~?]/ ) {
        $pattern .= $_;
    }
    elsif ( /^\w+$/ ) {
        $packages .= $_ . ' ';
    }

} # end of @ARGV loop

my $cmd = "aptitude install ";
$cmd   .=   $args       . ' ' if $args;
$cmd   .=   $packages   . ' ' if $packages;
$cmd   .= "'$pattern'"  . ' ' if $pattern;

print "\n$cmd\n\n";

system "su root -c \"$cmd\" ";

