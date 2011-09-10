#!/usr/bin/env zsh

[[ -z $1 ]] && print "No argument given\n" && exit


unary_tests () {
    print "File tests for '$1':"
    [[ -r $1 ]] && print - "-r\treadable"
    [[ -w $1 ]] && print - "-w\twriteable"
    [[ -x $1 ]] && print - "-x\texecutable"
    [[ -O $1 ]] && print - "-O\towner"
    [[ -G $1 ]] && print - "-G\tgroup"

    print -
    [[ -a $1 ]] && print - "-a\texists"
    [[ -b $1 ]] && print - "-b\tblock special"
    [[ -c $1 ]] && print - "-c\tchar special"
    [[ -d $1 ]] && print - "-d\tdir"
    [[ -e $1 ]] && print - "-e\texists"
    [[ -f $1 ]] && print - "-f\tregular"
    [[ -g $1 ]] && print - "-g\tsetgid bit"
    [[ -h $1 ]] && print - "-h\tsym link"
    [[ -k $1 ]] && print - "-k\tsticky bit"
    [[ -p $1 ]] && print - "-p\tpipe"
    [[ -s $1 ]] && print - "-s\tnonzero size"
    [[ -u $1 ]] && print - "-u\tsetuid bit"
    [[ -L $1 ]] && print - "-L\tsym link"
    [[ -S $1 ]] && print - "-S\tsocket"
    [[ -N $1 ]] && print - "-N\taccessed after mod"
    print

    print "String tests for '$1':"
    [[ -n $1 ]] && print - "-n\tnonzero length"
    # [[ -o $1 ]] && print - "-o\toption set"
    # [[ -t $1 ]] && print - "-t\topen file descriptor"
    [[ -z $1 ]] && print - "-z\tzero length"
    print "\n--------------------\n"

}


binary_tests () {
    print "Binary comparisons:"
    [[ $1 -nt $2 ]]   && print - "-nt\tnewer than"
    [[ $1 -ot $2 ]]   && print - "-ot\tolder than"
    [[ $1 -ef $2 ]]   && print - "-ef\tsame file"
    [[ $1 = $2 ]]     && print "=\tequal strings"
    [[ $1 != $2 ]]    && print "!=\tunequal strings"
    [[ $1 < $2 ]]     && print "<\tsorts before"
    [[ $1 > $2 ]]     && print ">\tsorts after"
    [[ $1 -eq $2 ]]   && print - "-eq\tequal numbers"
    [[ $1 -ne $2 ]]   && print - "-ne\tunequal numbers"
    [[ $1 -lt $2 ]]   && print - "-lt\tless than"
    [[ $1 -gt $2 ]]   && print - "-gt\tgreater than"
    [[ $1 -le $2 ]]   && print - "-le\tless than or equal to"
    [[ $1 -ge $2 ]]   && print - "-ge\tgreater than or equal to"
    # [[ ! "$1" ]]        && print "!\tfalse"
    # [[ $1 && $2 ]]    && print "&&\tlogical and"
    # [[ $1 || $2 ]]    && print "&&\tlogical or"
}

unary_tests $1

if [[ -n $2 ]]; then
    unary_tests "$2"
    binary_tests "$1" "$2"
fi


