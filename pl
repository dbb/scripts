#!/usr/bin/perl
use strict;

# dbbolton
# danielbarrettbolton at gmail

# $ARGV[0] is the code to be evaluated
# $ARGV[1] is any extra args
#   for example, 'wpl' means '-w -p -l'
# $ARGV[2] goes after the code, like a filename
# $ARGV[3] is the backup suffix
#
# Use a sole 0 to nullify an argument

# path to perl-- it's probably safe to put "perl" or "/usr/bin/perl"
my $perl = "perl";

my $code = $ARGV[0];

# args to be used every time; can be null
my $argstr = "-l";
my @args = split //, $ARGV[1];
for (@args) {
    $argstr .= " -$_" unless /^$/ or /^0$/;
}

my $post = $ARGV[2] unless /^0$/;

my $suf = $ARGV[3] unless /^0$/;

#my $command = "perl $argstr -i$suf -e '$code' $post";
my $command = "$perl ";

$command .= $argstr . ' ' if ($argstr);
$command .= "-i$suf "     if ($suf);
$command .= "-e '$code' " if ($code);
$command .= $post         if ($post);
print "\n$command\n\n";
system $command;
