#!/usr/bin/env perl
use 5.010;
use autodie;
use Scalar::Util qw(looks_like_number);
use strict;
use warnings;

# github.com/dbbolton

# variables
my $n = 0;
my $sum = 0;
my @data;


sub help {
    print <<'EOF';
Usage: std-dev [-f FILENAME] [DATA]

Options:    -f FILENAME
                Specify a path containing one data point per line

            -h show this help text

* Raw data can also be passed as arguments if -f is not given.

* If no arguments are given, std-dev will prompt the user for input.

EOF
} # end &help

sub args {
    my $i = 0;
    for ( @ARGV ) {
        if ( /^\-f$/ ) {
           &open_data( $ARGV[ $i + 1 ] );
           break;
        }
        elsif ( looks_like_number($_) ) {
            push @data, $_;
        }
        else {
            &help;
            exit;
        }

        $i++;
    }
} # end &args

sub get_data {
    say "Enter your group of data. Press <RETURN> after each item, " .
        "\nand Ctrl+d when finished:";

    chomp( my @tmp_data = <> );

    &check_data( \@tmp_data );

    
} # end &get_data

sub get_n {
    $n = scalar( @data );
}

sub open_data {
    my ( $file ) = @_;
    open( my $in,  "<",  $file );

    my @lines = <$in>;

    &check_data( \@lines );
} # end &open_data

sub check_data {
    my $input = shift;
    for ( @$input ) {
        push @data, $_ if ( looks_like_number($_) );
    }
} # end &check_data

&get_data unless @data;

&get_n;

say ' ' . '----------' . ' ';

print "Data: ";
print "'$_' " for @data;
say ' ';

&calc if ( $n && @data );


sub calc {
# Find and say the sum of all trials
( $sum += $_ ) for @data;
say "Sum:    \t$sum ";

# Find and say the average of all the trials
my $avg = $sum/$n;
say "Average:\t$avg ";

# Instantiate and find Sigma, (trial_i - avg)^2
my $Sigma = 0;
for ( @data ) {
   $Sigma += ($_ - $avg)**2
} 

# Find and say sigma, the standard deviation
my $sigma = sqrt($Sigma/($n-1));
$sigma = sprintf("%.5f", $sigma);
say "StdDev: \t$sigma ";

} # end &calc
