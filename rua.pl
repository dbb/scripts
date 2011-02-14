#!/usr/bin/perl
use strict;
use warnings;

# github.com/dbbolton

# rua - Regular User Aptitude script,
#       for installing or removing packages as a regular user.
#       Currently supports 'install' and 'remove'.
#       Requires 'su'.

my $args     = '-P ';
my $packages = '';
my $pattern  = '';
my $action;

for (@ARGV) {

    if ( /^(in|rm)$/ ) {
        $action = 'install' if /in/;
        $action = 'remove'  if /rm/;
    }

    elsif ( /^-/ ) {
        $args .=  $_ . ' ';
    }
    elsif ( /^[~?]/ ) {
        $pattern .= $_;
    }
    elsif ( /^[\w\-.]+$/ ) {
        $packages .= $_ . ' ';
    }

} # end of @ARGV loop

unless ( $action) {
    die "Supply 'in' for 'install' or 'rm' for 'remove'.\n";
}

my $cmd = "aptitude $action ";
$cmd   .=   $args       . ' ' if $args;
$cmd   .=   $packages   . ' ' if $packages;
$cmd   .= "'$pattern'"  . ' ' if $pattern;

print "\n$cmd\n\n";

system "su root -c \"$cmd\" ";

