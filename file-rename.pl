#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use File::Copy;

# $_ = ' !"#$%&\'()*+,:;<=>?@[\\]^`{|}~';
# s/[\ !"#\$%&'()*+,:;<=>?@\[\\\]^`{|}~]/_/g;
# s/[\ !"#\$%&'*+,:;?@\\]/_/g;
# s/[()<=>\[\]^`{|}~]/-/g;

my $path = $ARGV[0] // $ENV{PWD};
opendir( my $dh, $path );
my @files = sort( readdir($dh) );

my $new;
for (@files) {
    chomp;
    unless (/^[.]+$/) {
        $new = fixname($_);
        if ( $_ ne $new ) {
            print "Attempting to fix '$_' ------------\n";
            my $i=0;
            my $old_num;
            my $new_num;
            while ( -f $new ) {
                print "\t'$new' already exists here\n";
                if ( /(\d+)\./ or /(\d+)$/ ) {
                    print "\tUsing '$1' as an identifying number\n";
                    $old_num = $1;
                    $new_num = $old_num + 1;
                    $new =~ s/\Q$old_num\E/$new_num/;
                }
                elsif ( /(\.[\w]+)$/ ) {
                    print "\tUsing '$1' as the extension\n";
                    my $ext = $1;
                    $new =~ s/\Q$ext\E/\-$i$ext/;
                    $i++;
                }
                else {
                    print "\tNo file ext found\n";
                    $new .= "-$i";
                    $i++;
                }
            }
            print "\told: $_\n";
            print "\tnew: $new\n";
            move($_, $new);
        }
        else { print "'$_' is OK.\n"; }
    }

}

sub fixname {
    my ($name) = @_;
    $name =~ s/[\ !"#\$%'*+,:;?@\\]/_/g;
    $name =~ s/[()<=>\[\]^`{|}~]/-/g;
    $name =~ s/&/and/g;
    return $name;
}
