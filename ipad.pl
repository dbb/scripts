#!/usr/bin/perl
use LWP::Simple;
use strict;
use warnings;

my $interface = 'wlan0';
my $local = (split ':', 
	     (
	      (split ' ',`/sbin/ifconfig $interface`)[6]
	     )
	    )[1];
my $router= (split '<', 
	     (
	      (split ' ',
	       (get('http://checkip.dyndns.org/')))[5]
	     )
	    )[0];

print "\nInterface:  $local\n".
      "Router:     $router\n\n";

