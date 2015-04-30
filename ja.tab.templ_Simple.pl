#!/usr/bin/env perl

########
# datのname要素を書き出すだけ
########

#厳密な検査 / システムモジュール
use strict ;
use warnings ;

#変数宣言
my @dats ;
my @names ;
my $file_h ;
#ディレクトリにあるファイルを取得する
@dats = glob "*.dat" ;
my $out_file ; 
#ファイル指定
if($#ARGV < 1){
    print "All check\n" ;
    $out_file = $ARGV[0] ;
    foreach my $dat ( @dats){
	print $dat."\n----\n" ;
	open($file_h,"<",$dat) or die("File can't open") ;
#全行チェック
	while(my $line =  readline($file_h)){
	    chomp($line) ;
	    #nameで始まる行を代入する
	    if($line =~ /name=(.*)/){
		push(@names,$1) ;
	    }
	}
    }
}else{
    print "Single check\n" ;
    $out_file = $ARGV[1] ;
    open($file_h,"<",$ARGV[0]) or die("File can't open") ;
    #全行チェック
    while(my $line =  readline($file_h)){
	chomp($line) ;
	#nameで始まる行を代入する
	if($line =~ /name=(.*)/i){
	    push(@names,$1) ;
	}
    }
}

#ファイルに書き込む
open($file_h,">>",$out_file) or die("File can't open") ;
foreach my $name ( @names){
    print $file_h $name."\n\n" ;
    print $name."\n\n" ;
}

