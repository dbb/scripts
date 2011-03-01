#!/usr/bin/perl
use 5.010;
use strict;
use String::ShellQuote;
use warnings;

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
    elsif ( /^[\w\-\.=]+$/ ) {
        $packages .= $_ . ' ';
    }

} # end of @ARGV loop

my $cmd = 'aptitude install ';
$cmd   .= $args        . ' ' if $args;
$cmd   .= $packages    . ' ' if $packages;
$cmd   .= "'$pattern'" . ' ' if $pattern;

my $quoted  = shell_quote $cmd;
my $su_call = 'su -c ' . $quoted . ' root';

say "$su_call";

system " $su_call ";

exit 0;

