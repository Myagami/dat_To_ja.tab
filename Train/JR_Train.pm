package Train::JR_Train;

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
	JRH => "JR北海道",
	JRE => "JR東日本",
	JNR => "国鉄",
	JRC => "JR東海",
	JRW => "JR西日本",
	JRS => "JR四国",
	JRK => "JR九州",
    } ;

    $self = shift ;
    $self->{name} =~ /^([A-z]{1,}) / ;
    return $camp->{$1} ;
}

sub type{#車両の種別取得
    #格納変数
    my $data = null ;
    #形式
    my $types = {
	T => "サハ",
	M => "モハ",
	Tc => "クハ",
	Mc => "クモハ",
	Ts => "サロ",
	Thsc => "クロハ",
	Kiha => "キハ",
	Kiro => "キロ",
	Kisaha => "キサハ",
	TsD => "サロ",
	TA => "サハ",
	Mu => "モハ",
	TAc => "サハ"
	    
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    $self->{name} =~ s/\'//g ;

    if($self->{name} =~ /Kiha|Kiro|Kisaha/){#気動車
	$self->{name} =~ /^[A-z]{1,} DC_([A-Za-z0-9_]{1,})(.*)/ ;
	my @type = split(/_/,$1) ;
	
	$data =  $types->{$type[0]} ;
	$data .= $type[1]."形" ;

	if(defined($type[2])){
	    $data .=  $type[2] ;
	    $data .= "番台" ;
	}

	if(defined($2)){
	    $data .=  $2 ;
	}
    }else{
	#形式部分を取得
	$self->{name} =~ /^[A-z]{1,} (([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*))/ ;
	#形式部分を分割
	my @type = split(/_/,$1) ;
	#print join("-",@type)."\n" ;
	#称号取得
	$type[0] =~ s/[0-9']{1,}// ;
	$data = $types->{$type[0]} ;

	#形式番号取得
	#print $type[1]."\n" ;
	#番台取得
	if(defined($type[2])){
	    $type[2] =~ s/\x0D$// ;
	    $data .= $type[1]."系" ;
	    
	    $type[2] =~ /([0-9]{1,})(.*)/ ;
	    $data .= $1."番台" ;
	    $data .= $2 ;
	    
	}else{
	    $type[1] =~ s/\x0D$// ;
	    $type[1] =~ /([0-9A-Za-z]{1,})(.*)/ ;
	    $data .= $1."系" ;
	    $data .= $2 ;
	}

    }
    return $data ;

}

1;
