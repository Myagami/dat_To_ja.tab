package JR_Train;

sub new{#インスタンス生成
    my $pak = shift ;
    my $hash = {
    };
    bless $hash,$pak;    
}

sub get_Name{#名前を取得する
    my $self = shift ;
    $self->{name} = shift ;
    print $self->{name} ;
    print "\n" ;
}

sub campany{#会社名を取得する
    #会社名
    my $camp = {
	JRH => "JR北海道"
    } ;

    $self = shift ;
    $self->{name} =~ /^([A-z]{1,}) / ;
    print $camp->{$1} ;
    print "\n" ;
}

sub type{#車両の種別取得
    #形式
    my $types = {
	T => "サハ",
	M => "モハ",
	Tc => "クハ",
	Mc => "クモハ"
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;

    #形式部分を取得
    $self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*)/ ;

    #形式部分を分割
    #list(my $type,my $num,my $serial) = split(/_/,$1) ;
    my @type = split(/_/,$1) ;
    
    print join("/",@type)."\n" ;
    print $2."\n" ;

}

1;
