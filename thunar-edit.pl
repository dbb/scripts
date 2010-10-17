#!/usr/bin/perl
use strict;
use warnings;
use autodie;

my $file = $ARGV[0];

my $app;

if ( $file =~ /\.(flac|mp3|ogg|wav)$/i ) {
    $app = 'audacity';
}
elsif ( $file =~ /\.(csv|ods|ots|xls|xlt)$/i ) {
    $app = 'ooffice -calc';
}
elsif ( $file =~ /\.(doc|docx|odt|ott|rtf)$/i ) {
    $app = 'ooffice -writer';
}
elsif ( $file =~ /\.(jpg|png|gif|xcf|xpm)$/i ) {
    $app = 'gimp';
}
elsif ( -T $file ) {
    $app = 'gvim --remote-tab';
}
else {
    exit;
}

defined( my $pid = fork );
unless ( $pid ) {
    close( STDIN );
    close( STDOUT );
    close( STDERR );
    exec "$app $file";
    exit 0;
}
