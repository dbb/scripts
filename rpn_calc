#!/usr/bin/env perl
use 5.010;

# https://github.com/dbb


for my $arg ( @ARGV ) {
    &help if $arg =~ /\-h/;
    unless ( $arg =~ /\s/ ) {
        die "Terms must be space-separated";
    }
    my $tmp;
    my $orig = $arg;
    while ( $arg =~ m{[+*/-]} ) {
        my $expr = $arg;
        if (
##            12  3                 4  5                 6
            $arg =~
            s{((-?(0[bx])?[\d_a-f]+)\s+(-?(0[bx])?[\d_a-f]+)\s+([+*/-]))}{PAT}i
            )
        {
            $tmp = eval "$2 $6 $4";
            $expr =~ s/PAT/$tmp/;
            $arg  =~ s/PAT/$tmp/;
            print "$expr\t= $arg\n" if $arg =~ m{[+*/-]};
        } ## end if ( $arg =~ ...)
        else {
            die "Bad regex.";
        }

    } ## end while ( $arg =~ m{[+*/-]})

    print "$orig\t= $arg\n\n";
} ## end for my $arg ( @ARGV )


sub help {
    print << 'EOF';
Usage:
% rpn_calc 'expr1' 'expr2'

Where any exprN is an arithmetic expression in Reverse Polish Notation.
The output is always in base 10, but input can be binary (0b...),
decimal, hexadecimal (0x...), or octal (0...). Valid operators are addition
(+), subtraction (-), multiplication (*), and division (/). Numbers and 
operators must be space separated. An underscore may be used to make large
numbers more readable (e.g. 1_000_000) but commas may not.

Running rpn_calc with the option -h or --help will display this help text and
exit.

Examples:
% rpn_calc '0b010 0b100 +'
0b010 0b100 +   = 6

% rpn_calc '0xaa 0x4f /'
0xaa 0x4f /     = 2.15189873417722

% rpn_calc '1 2 + 3 +'
1 2 + 3 +       = 3 3 +
1 2 + 3 +       = 6

% rpn_calc '1 1 /' '2 1 -'
1 1 /   = 1

2 1 -   = 1


Report all issues at: https://github.com/dbb

EOF
    exit;
} ## end sub help

