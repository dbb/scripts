#!/usr/bin/perl
use strict;

# dbbolton
# danielbarrettbolton at gmail

# $ARGV[0] is the code to be evaluated
# $ARGV[1] is any extra args
#   for example, 'wpl' means '-w -p -l'
# $ARGV[2] goes after the code, like a filename

my $code = $ARGV[0];
my $argstr = '';
my $post = $ARGV[2] // ' ';

my @args = split //, $ARGV[1];
for (@args) {
    $argstr .= " -$_" unless /^$/;
}

my $command = "perl" . $argstr . " -e '$code'" . $post;
print "\n$command\n\n";
system $command;
