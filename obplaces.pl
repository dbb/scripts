#!/usr/bin/env perl
use strict;
use warnings;
use File::Basename;

# dbbolton
# danielbarrettbolton@gmail.com

my $filemanager = "thunar";
my $bookmarks = "$ENV{HOME}/.gtk-bookmarks";
open(my $in, "<", "$bookmarks") or die "Can't ($bookmarks): $!";

my @lines = <$in>;
chomp(@lines);

# Heading #############################
print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
print "<openbox_pipe_menu>\n";

# Default bookmarks in thunar #########
print "<item label=\"".$ENV{USER}."\">\n";
print " <action name=\"Execute\">\n";
print "  <execute>\n";
print "   ".$filemanager." $ENV{HOME} \n";
print "  </execute>\n";
print " </action>\n";
print "</item>\n";

print "<item label=\"Trash\">\n";
print " <action name=\"Execute\">\n";
print "  <execute>\n";
print "   ".$filemanager." trash:// \n";
print "  </execute>\n";
print " </action>\n";
print "</item>\n";

print "<item label=\"Desktop\">\n";
print " <action name=\"Execute\">\n";
print "  <execute>\n";
print "   ".$filemanager." /home/$ENV{USER}/Desktop \n";
print "  </execute>\n";
print " </action>\n";
print "</item>\n";

print "<item label=\"File System\">\n";
print " <action name=\"Execute\">\n";
print "  <execute>\n";
print "   ".$filemanager." / \n";
print "  </execute>\n";
print " </action>\n";
print "</item>\n";

print "<separator />\n";

# User-specified bookamrks ############
foreach (@lines) {
    my $label = basename $_;
    
    print "<item label=\"".$label."\">\n";
    print " <action name=\"Execute\">\n";
    print "  <execute>\n";
    print "   ".$filemanager." ".$_."\n";
    print "  </execute>\n";
    print " </action>\n";
    print "</item>\n";
}

print "</openbox_pipe_menu>\n";

close $in or die "$in: $!";
