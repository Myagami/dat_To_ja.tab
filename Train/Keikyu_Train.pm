package Train::Keikyu_Train;

sub new{#インスタンス生成
    my $pak = shift ;
    my $hash = {
    };
    bless $hash,$pak;    
}

sub get_Name{#名前を取得する
    my $self = shift ;
    $self->{name} = shift ;
}

sub campany{#会社名を取得する
    #会社名
    my $camp = {
	Keikyu => "京浜急行",
	Keihin => "京浜電気鉄道",
	Shonan => "湘南電気鉄道"
    } ;

    $self = shift ;
    $self->{name} =~ /^([A-z]{1,}) / ;
    return $camp->{$1} ;
}

sub type{#車両の種別取得
    #格納変数
    my $data = null ;

    #my $types = {
#	T => "サハ",
#	M => "モハ",
#	Tc => "クハ",
#	Mc => "モハ"
#    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    $self->{name} =~ s/\'//g ;

	#形式部分を取得
	$self->{name} =~ /^[A-z]{1,} (([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*))/ ;
	#形式部分を分割
	my @type = split(/_/,$1,2) ;
	#print join("-",@type)."\n" ;
	#称号取得
	$type[0] =~ s/[0-9']{1,}// ;
    $data = $type[0] ;

	#形式番号取得
	#
	#print $type[1]."\n" ;
	#番台取得
	if(defined($type[2])){
	    $type[2] =~ s/\x0D$// ;
	    $data .= $type[1]."形" ;
	    
	    $type[2] =~ /([0-9]{1,})(.*)/ ;
	    $data .= $1."番台" ;
	    my $nm = Series_Num($2) ;
	    
	    $data .= $nm ;
	    
	}else{
	    $type[1] =~ s/\x0D$// ;
	    $type[1] =~ /([0-9A-Za-z]{1,})(.*)/ ;
	    $data .= $1."形" ;
	    my $nm = Series_Num($2) ;

	    $data .= $nm ;
	}
    $data .= "(".$type[0].")";
    return $data ;

    sub Series_Num{#番台取得
	my $nm = shift ;
	my $data = $nm ;
	$nm =~ s/non cooler/非冷房車/ ;
	$nm =~ s/Proto type/試作車/ ;
	$nm =~ s/renewal:VVVF custom/更新車/ ;
	$nm =~ s/Keikyu Blue Sky Train/京急 ブルースカイトレイン/ ;
	$nm =~ s/type/タイプ/ ;
	$nm =~ s/Renewal/更新車/i ;
	$nm =~ s/3doors/3ドア車/ ;
	$nm =~ s/2doors/2ドア車/ ;


	$data = $nm ;

	return $data ;
    }
}

1;
