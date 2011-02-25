#!/usr/bin/env perl
use strict;
use warnings;

# dbbolton
# danielbarrettblton@gmail.com

print "Enter the source:\n";
my $src = <STDIN>;
chomp($src);

print "Enter the server number:\n";
my $num = <STDIN>;
chomp($num);
my $server = "192.168.1.".$num.":/share";

my @sync = qw(
rsync
--verbose
--progress
--stats
--compress
--rsh=/usr/bin/ssh
--recursive
--times
--perms
--links
);

push(@sync,$src);
push(@sync,$server);

system(@sync);

print "\nmedia-sync complete.\n"

# example rsync command 
#
# rsync --verbose  --progress --stats --compress --rsh=/usr/bin/ssh \
#       --recursive --times --perms --links --delete \
#       --exclude "*bak" --exclude "*~" \
#       /www/* webserver:simple_path_name


