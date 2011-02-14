#!/usr/bin/perl -w
use strict;
use autodie;
use AptPkg::Cache;                # debian: libapt-pkg-perllibapt-pkg-perl
use List::MoreUtils qw(natatime); # debian: liblist-moreutils-perl

# github.com/dbbolton

my $cache = AptPkg::Cache->new;
open(my $out, ">",  "apt-carbon.sh");

print $out <<'EOF';
#!/bin/sh
aptitude update && aptitude safe-upgrade
aptitude install -P
EOF

my @pkg_list;
for (split "\n", `dpkg -l`) {
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

# Pasting ###################################################################

# old, dirty form that doesn't use AptPkg::Cache
# if ( ! (`apt-cache policy curl` =~ /\(none\)/))

if ( $cache->{'curl'}->{'CurrentState'} eq 'Installed' ) {
	print "Using curl...\n";
	system "cat apt-carbon.sh | curl -F 'sprunge=<-' http://sprunge.us";
}

elsif ( $cache->{'pastebinit'}->{'CurrentState'} eq 'Installed' ) {
	print "Using pastebinit...\n";
    system "pastebinit apt-carbon.sh";
}
else {
	print "Automatic upload failed: Neither curl nor pastebinit is installed.\n".
		  "Your script is located at ./apt-carbon.sh\n";
}

chmod 0744, $out;
close $out;

