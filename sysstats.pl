#!/usr/bin/perl -lw
use autodie;
use POSIX qw(strftime);
use strict;

# Subroutines #############################################################

sub act {
	open(my $in,  "<",  "/proc/meminfo");
	while (<$in>) {
		if (/Active:/) {
			$_ =~ /([0-9]+)/;
			my $mb = int($1/1024);
			print $mb . "MB";;
		}
	}
	close $in;
}

sub bat {
	$_ = (split " ", `acpi -b`)[-1];
	print;
}

sub date {
	$_ = strftime "%d/%m %R", localtime;
	print;
}

sub help {
	print "  arg\t\t\tdescription\n".
		  "-a | act\t\tActive memory\n".
		  "-b | bat\t\tBattery charge %\n".
		  "-d | bat\t\ttime and Date %\n".
		  "-l | load\t\tavg Load in last minute\n".
		  "-t | temp\t\tfirst core Temperature\n"
;
}

sub load {
 	chop($_ = (split " ", `uptime`)[-3]);
#	$_ = (split ':', `uptime`)[-1];
	print;
}

sub temp {
	foreach (split "\n", `sensors`) {
		if (/0:/) {
			$_ =~ /[+-]([0-9.]+)/;
			print "$1C";
		}
	}
}

# Output ##################################################################

unless (defined($ARGV[0])) {
	&help;
}

foreach (@ARGV) {
	if (/act/ || /^-a$/ ) {
		&act;
	}

	elsif (/bat/ || /^-b$/ ) {
		&bat;
	}

	elsif (/date/ || /^-d$/ ) {
		&date;
	}

	elsif (/load/ || /^-l$/) {
		&load;
	}

	elsif (/temp/ || /^-t$/) {
		&temp;
	}
	else {
		&help;
	}

}
