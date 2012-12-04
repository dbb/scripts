#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use File::Basename;
use File::Copy;

## https://github.com/dbb

## The purpose of this script is to fix a conflict that occurs on Debian
## systems where the proprietary Nvidia driver has been installed with
## Nvidia's installer. See also:
## https://github.com/dbb/scripts/blob/master/nvidia-glx-fix.pl

# Options
my $backup_ext = ".orig";

# Don't change these unless you know what you're doing
my $prefix     = "/usr";
my $lib        = "$prefix/lib";
my $link_name  = "libOpenCL.so";
my $nv_name    = "libnvidia-opencl.so";

# If you just want to print what the script would do, set this to 1
# Otherwise, set it to 0 and run as root.
my $simulate = 1;

my $choice;
my @files;

say "Searching for available versions of libOpenCL...";
for (<$lib/$nv_name*>) {
    if (/$nv_name.([\d\.])+$/) {
        push @files, $_;
        s/$nv_name\.//;
        say "Found version '" . basename $_ . "'";
    }
}

say "\n\tNote: version '1' is typically a symlink to the last-installed\n\tversion that is created by Nvidia's installer.";

# The globbed array should be lexographical, but just to be sure:
my @sorted = sort @files;

# Pick the latest version.
# (If you want to set a static version, set $choice manually.)
$choice = $sorted[-1];
print "\nUsing '$choice' as libglx.so\n";

if ( $simulate ) {
    say "\nSimulated action:";
    say "\nmv $lib/$link_name $lib/${link_name}${backup_ext}";
    say "ln -s $choice $lib/$link_name";
}
else {
    # Now create the proper link:
    say "\nRestoring symlink (requires root permissions)";
    move "$lib/$link_name", "$lib/${link_name}${backup_ext}";
    symlink "$choice", "$lib/$link_name";
}

