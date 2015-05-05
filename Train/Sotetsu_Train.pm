package Train::Sotetsu_Train;

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
	Sotetsu => "相模鉄道",
    } ;

    $self = shift ;
    $self->{name} =~ /^([A-z]{1,}) / ;
    return $camp->{$1} ;
}

sub type{#車両の種別取得
    #格納変数
    my $data = Null ;

    my $types = {
	T => "サハ",
	M => "モハ",
	Tc => "クハ",
	Mc => "クモハ",
	cMc => "モハ",
	Mgc => "モニ"
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    #$self->{name} =~ s/\'//g ;

	#形式部分を取得
    $self->{name} =~ /^[A-z]{1,} (([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*))/ ;
    #形式部分を分割
    my @type = split(/_/,$1,2) ;
   
    
    $type[0] =~ s/[0-9']{1,}// ;
    if($types->{$type[0]}){
	$data = $types->{$type[0]} ;
    }else{
	$data = $type[0] ;
    }



    #print join("-",@type)."\n" ;
    #称号取得
    
    

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

    my $types_2 = {

    };
    ##方向設定等
    #$data .= "(".$types_2->{$type[0]}.")";
    print "Type:".$type[0]." / ".$types_2->{$type[0]}."\n" ;
    
    #if($types_2->{$type[0]}){
    #$data .= "(".$types_2->{$type[0]}.")";
    #}else{
    #$data .= "(".$type[0].")";
    #}

    return $data ;

    sub Series_Num{#番台取得
	my $nm = shift ;
	my $data = $nm ;
	$nm =~ s/non cooler/非冷房車/ ;
	$nm =~ s/Proto type/試作車/; 
	$nm =~ s/type/タイプ/i ;
	$nm =~ s/Front/前方/i ;
	$nm =~ s/Back/後方/i ;
	$nm =~ s/VVVF/VVVF制御車/i ;
	$data = $nm ;

	return $data ;
    }
}

1;
