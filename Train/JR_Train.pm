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
	JRE => "JR東日本"
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
	Ts => "サロ"
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    $self->{name} =~ s/\'//g ;

    if($self->{name} =~ /Kiha/){

    }else{
	#形式部分を取得
	$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*)/ ;

	#形式部分を分割
	#list(my $type,my $num,my $serial) = split(/_/,$1) ;
	my @type = split(/_/,$1) ;
	$type[0] =~ s/[0-9]//g ;
	
	#print join("/",@type)."\n" ;
	
	#print $types->{$type[0]} ;
	$data = $types->{$type[0]} ;
	$data .=  $type[1] ;
	$data .= "系" ;
	
	if(defined($type[2])){
	    $data .=  $type[2] ;
	    $data .= "番台" ;
	}
	
	if(defined($2)){
	    $data .=  $2 ;
	}
    }
    return $data ;

}

1;
