#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use File::Copy;

# $_ = ' !"#$%&\'()*+,:;<=>?@[\\]^`{|}~';
# s/[\ !"#\$%&'()*+,:;<=>?@\[\\\]^`{|}~]/_/g;
# s/[\ !"#\$%&'*+,:;?@\\]/_/g;
# s/[()<=>\[\]^`{|}~]/-/g;

my $path = "$ENV{PWD}";
opendir( my $dh, $path );
my @files = sort( readdir($dh) );

my $new;
foreach (@files) {
    chomp;
    unless (/^[.]+$/) {
        $new = fixname($_);
        if ( $_ ne $new ) {
            my $i=0;
            while ( -f $new ) {
                if (/(\.[\w]+)$/) {
                    my $ext = $1;
                    $new =~ s/\Q$ext\E/\-$i$ext/;
                    $i++;
                }
                else {
                    print "no file ext found\n";
                    $new .= $i;
                    $i++;
                }
            }
            print "old: $_";
            print "new: $new\n";
            move($_, $new);
        }
        else { print "\"$_\" is OK."; }
    }

}

sub fixname {
    my ($name) = @_;
    $name =~ s/[\ !"#\$%&'*+,:;?@\\]/_/g;
    $name =~ s/[()<=>\[\]^`{|}~]/-/g;
    return $name;
}
