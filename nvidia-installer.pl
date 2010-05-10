#!/usr/bin/perl
use strict;
use warnings;

use autodie;
use AptPkg::Cache; # libapt-pkg-perl

# dbbolton
# danielbarrettbolton@gmail.com


# setting up a cache to be used later
my $cache = AptPkg::Cache->new;

# check to see if the script is run as root
unless ( $ENV{USER} eq "root" ) {
    print "Must be root; aborting.\n";
    exit;
}

# check to see if Xorg is running
if ( `ps -e` =~ /Xorg/ ) {
    print "Xorg running; aborting.\n";
    exit;
}

# remove the nvidia module
print "Unloading the 'nvidia' module...\n";
system "rmmod -v nvidia";
print "\n";

# Nvidia's verion ###########################################################
if ( $ARGV[0] =~ /nv/ ) {

# try to remove debian nvidia packages
print "Attempt automatic removal of Debian packages? (y/n) ";
my $aprm = <STDIN>;
if ( $aprm =~ /y/i ) {
    system "aptitude remove -P '~nnvidia'";
}

# the path is the current directory; change if applicable
my $path = "$ENV{PWD}";

# find files in the path
opendir(my $dh, $path);
my @files = readdir($dh);

# some variables about to be used
my @args;
my @versions;
my $version = '';

# make a list of potential installers
foreach (@files) {
    if ( /NVIDIA-Linux-x86_64-(\d{3}\.\d{2}\.\d{2})-pkg2\.run/ ) {
        push @versions, $1;
    }
}

# check if ia32-libs is installed
my $ia32 = $cache->{"ia32-libs"}->{"CurrentState"};

if ( $ia32 eq "Installed" ) {
    print "ia32-libs installed; enabling 32-bit compatibility.\n";
    @args = qw#--compat32-prefix=/usr --compat32-libdir=lib32 --compat32-chroot=#

}
else {
    print "ia32-libs not installed; not enabling 32-bit compatibility.\n";
    @args = (" ");
}

# if there is only one installer, run it
if ( @versions == 1 ) {
    print "Only 1 installer found in $path\nExecuting it...\n";
    &install($versions[0]);
}
# if there is more than one, ask the user to pick
elsif ( @versions > 0 ) {
    my $i = 0;
    print "Available versions:\n";
    foreach (@versions) {
        print "$_ \t$i\n";
        $i++;
    }
    print "Select version [0-" . ((scalar(@versions))-1) . "]: ";
    chomp( my $sel = <STDIN> );

    # make sure the user's selection is ok
    if ( $versions[$sel] ) {
        &install($versions[$sel]);
    }
    else {
        print "Invalid selection. Aborting.\n";
        exit;
    }
}
else {
    print "No installer files found.\n";
}

sub install {
    my ($v) = @_;
    my $installer = "NVIDIA-Linux-x86_64-$v-pkg2.run";
    if ( -x $installer ) {
        system "sh $path/$installer @args";
    }
    else {
        print "WARNING: $installer is not executable; modifying.\n\n";
        my $mode = 0644;
        chmod $mode, "$path/$installer";
        system "echo $path/$installer @args";
    }
}

}
# end of nvidia method

# debian method ###########################################################
elsif ( $ARGV[0] =~ /deb/ ) {

# find available versions in the apt-cache
my $deb_vers = $cache->{"nvidia-kernel-source"}->{VersionList};

# make a list of the version numbers
print "Available versions: \n";
my $i=0;
my @avail;
for my $v (@$deb_vers) {
    print "$v->{VerStr}\t$i\n";
    push @avail, $v->{VerStr};
    $i++;
}

if ( @avail == 1 ) {
    &apin($avail[0]);
}
# ask the user to choose a version if there are more than 1
elsif ( @avail > 0 ) {
print "Choose version [0-" . ($i-1) . "]: ";
chomp( my $sel = <STDIN> );

if ( $avail[$sel] ) {
    &apin($avail[$sel]);
}
else {
    print "Bad selection; aborting.\n";
}
}
# otherwise, there aren't any
else {
    print "No versions are available to apt; aborting.\n";
    exit;
}

# the system call; modify as needed
sub apin {
    my ($v) = @_;
    system "aptitude install module-assistant nvidia-kernel-common && \
            m-a prepare && \
            aptitude install nvidia-kernel-source=$v && \
            m-a a-i nvidia-kernel-source && \
            aptitude install nvidia-glx=$v nvidia-glx-ia32=$v libvdpau1 \
            nvidia-vdpau-driver=$v nvidia-vdpau-driver-ia32=$v"

}

}
# end of debian method ######################################################

# need one argument
else {
    print "Specify a method: 'deb' or 'nv'.";
}
