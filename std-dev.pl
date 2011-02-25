#!/usr/bin/env perl
use strict;
use warnings;

# dbbolton
# danielbarrettbolton@gmail.com

# Ask the user for data
print "Enter your group of data. Press <RETURN> after each item, 
and ^D when finished:\n";

# Save the user's data as an array
my @trials = <>;

# Find and print n, the number of trials
my $n = scalar(@trials);
print "You did $n trials.\n";

# Instantiate the sum
my $sum = 0;

# Find and print the sum of all trials
($sum+=$_) for @trials;
print "The sum is: ".$sum." \n";

# Find and print the average of all the trials
my $avg = $sum/$n;
print "The average is: ".$avg." \n";

# Instantiate and find Sigma, (trial_i - avg)^2
my $Sigma = 0;
foreach (@trials) {
   $Sigma += ($_ - $avg)**2
} 

# Find and print sigma, the standard deviation
my $sigma = sqrt($Sigma/($n-1));
$sigma = sprintf("%.5f", $sigma);
print "The standard deviation is: ".$sigma."\n";
