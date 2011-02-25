#!/usr/bin/perl -wl
use POSIX qw(ceil floor);
use strict;

my $pi = 3.14159265358979;
my $e =  2.71828182845905;

foreach (@ARGV) {
	s:\^:\*\*:g;
    if (/system/ or /exec/) {
        print "Found 'system'/'exec'; not evaluating.";
    }
	elsif (/[-]{1,2}[h]/ or /help/) {
		&help;
	}
	elsif (/\$/) {
		if (/\$e/ or /\$pi/) {
			print eval;
		}
	}
	elsif (defined) {
		print $_ . ' = ' . eval;
		warn $@ if $@;
	}
	else {
		print "undefined argument";
	}
}

sub help {
print "
constants: \$e, \$pi

format: binary (leading 0b), decimal,
        hexadecimal (leading 0x), octal (leading 0),
        scientific (e.g. 2.04e4),

operations: +, -, *, /, ^ or **, %, ()
            ceil(), int(), floor()
            log(); lg(base, x)
            sin(), cos(), tan()
            sind(), cosd(), tand()
";

}

sub sind {
	my $x = sin(($_[0]/180) * $pi);
	return $x;
}

sub cosd {
	my $x = cos(($_[0]/180) * $pi);
	return $x;
}

sub tan {
	my $x = (sin($_[0]) / cos($_[0]));
	return $x;
}

sub tand {
	my $x = &tan(($_[0]/180) * $pi);
	return $x;
}

sub lg {
	my $y =  log($_[1]) / log($_[0]);
	return $y;
}
