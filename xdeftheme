#!/usr/bin/env perl
use strict;
use warnings;
use File::Copy;

# dbbolton
# danielbarrettbolton@gmail.com

# terminal to use
my $term = "xterm";

# Path to your Xdefaults themes
my $path = "$ENV{HOME}/Documents/xdefaults/";

# .Xdefaults file location
my $config = "$ENV{HOME}/.Xdefaults";
my $backup = "$path/xdefaults_backup";;

# the terminal's process ID, if running
my $termpid = `pidof $term`;

# Find available files
opendir(my $dh, $path) || die "can't opendir $path: $!";
my @files = sort(readdir($dh));

my $i = 0;
print "Files found: \n";
foreach (@files) {
  unless (/^\.$/ || /^\.\.$/) {
    print "$i\t$_\n";
    $i += 1;
}
}

# Ask which theme file to use
my $newtheme = '';
sub getnew {
  print "\nEnter theme number: ";
  my $n = <>;
  chomp($n);
  $n += 2;
  return $n;
}

# Make sure the name is ok
my $usenew = "n";
sub checkfile {
 if (-e "$path/$newtheme" && -r "$path/$newtheme" ) {
    print "File is OK.\n";
 }
else {
    print "\nEither the specified file does not exist in the theme directory, or you do 
not have access to it.\n";
    $newtheme = getnew();
    checkfile();
 }
}

sub verify {
    print "Apply theme \"$newtheme\" ? (y/n) ";
    $usenew = <>;
    chomp($usenew);
    if ($usenew eq "y" || $usenew eq "Y") {
	writefile();
    }
    elsif ($usenew eq "n" || $usenew eq "N") {
	print "Aborting.\n";
    }
    else {
	print "Invalid response. Type 'y' or 'n'.\n";
	verify();
    }
}

sub starttint {
  if ($termpid) {
    system "kill $termpid";
  }

  defined(my $pid = fork) || die "Cannot fork: $!";
  unless ($pid) {
    close(STDIN) or die "Can't close STDIN: $!\n";
    close(STDOUT) or die "Can't close STDOUT: $!\n";
    close(STDERR) or die "Can't close STDERR: $!\n";
    exec "xrdb -load $config && $term";
    exit 0;
  }
}

sub writefile {
  if (-e $config) {
      print "Backing up ~/.Xdefaults to \n  $backup ...\n";
      move($config, $backup) || die "Error moving: $!";
  }
  print "Writing $newtheme to ~/.Xdefaults ...\n";
  copy("$path/$newtheme", $config) || die "File cannot be copied: $!";
  print "(Re)starting $term ... \n";
  starttint();
}

my $index = getnew();
$newtheme = $files[$index];
checkfile();
verify();
