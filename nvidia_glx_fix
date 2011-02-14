#!/usr/bin/env perl
use strict;
use warnings;
use File::Basename;
use File::Copy;

# http://github.com/dbbolton/

# Options:
my $dir        = '/usr/lib/xorg/modules/extensions';
my $backup_ext = '.orig';
my $target     = 'libglx.so';

my $choice;

# Find all potential Nvidia GLX plugin files:
my @nv_glx_files;
for (<$dir/libglx*>) {
    if (/libglx\.so\.([\d\.])+$/) {
        push @nv_glx_files, $_;
        s/libglx\.so\.//;
        print "Found version '" . basename $_ . "'\n";
    }
}

# The globbed array should be lexographical, but just to be sure:
my @sorted = sort @nv_glx_files;

# Pick the latest version.
# (If you want to set a static version, set $choice manually.)
$choice = $sorted[-1];
print "\nUsing '$choice' as libglx.so\n";

# Now create the proper link:
move "$dir/$target", "$dir/libglx.so$backup_ext";
symlink "$choice", "$dir/$target";

print "\nFinished.\n";

exit 0;

