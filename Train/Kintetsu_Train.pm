package Train::Kintetsu_Train;

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
	Kintetsu => "近鉄"
	    
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
	T => "サ",
	Td => "サ",
	Tcd => "ク",
	To => "ク()",
	Tc => "ク",
	Tsc => "サ",
	M => "モ",
	Mo => "モ()",
	Msc => "モ",
	Mc => "モ",
	Ms => "モ"
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    $self->{name} =~ s/\'//g ;


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

    return $data ;

}

1;
