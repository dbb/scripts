#!/usr/bin/perl -w
use strict;
use autodie;
use List::MoreUtils qw(natatime); # debian: liblist-moreutils-perl

# dbbolton
# danielbarrettbolton@gmail.com

open(my $out, ">",  "apt-carbon.sh");

print $out "#!/bin/sh\n".
 		   "aptitude update && aptitude safe-upgrade\n".
 		   "aptitude install -P ";

my @pkg_list;
foreach (split "\n", `dpkg -l`) {
	if (/^i/) {
		my $name = (split ' ', $_)[1];
		push @pkg_list, $name;
	}
}

my $j = natatime 3, @pkg_list;
while (my @vals = $j->()) {
	print $out "@vals \\\n";
}
print $out " \n# end of apt-carbon.sh";

my $upload = '';
if ( ! (`apt-cache policy curl` =~ /\(none\)/)) {
	print "Using curl...\n";
	system "cat apt-carbon.sh | curl -F 'sprunge=<-' http://sprunge.us";
}
elsif (! (`apt-cache policy pastebinit` =~ /\(none\)/)) {
	print "Using pastebinit...\n";
}
else {
	print "Automatic upload failed: Neither curl nor pastebinit is installed.\n".
		  "Your script is located at ./apt-carbon.sh\n";
}

system "chmod 744 apt-carbon.sh";
close $out;