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
	Keikyu => "京浜急行電鉄",
	Keihin => "京浜電気鉄道",
	Shonan => "湘南電気鉄道"
    } ;

    $self = shift ;
    $self->{name} =~ /^([A-z]{1,}) / ;
    return $camp->{$1} ;
}

sub type{#車両の種別取得
    #格納変数
    my $data = Null ;

    my $types = {
	M => "デハ",
	T => "サハ",
	Tp => "サハ",
	Ts => "サハ",
	Tc => "クハ",
	Mc => "デハ",
	M1 => "デハ",
	M2 => "デハ",
	M3 => "デハ",
	M1c => "デハ",
	M2c => "デハ",
	M3c => "デハ",
	Mu => "デハ",
	Ms => "デハ" ,
	M1cu => "デハ",
	M2cu => "デハ",
	M1cs => "デハ",
	M2cs => "デハ",
	M1u => "デハ",
	M2u => "デハ",
	M1s => "デハ",
	M2s => "デハ",
	Muc => "デハ",
	Msc => "デハ",
	Mcu => "デハ",
	Mcs => "デハ"
    } ;

    #$self->{name} =~ /^[A-z]{1,} ([A-Za-z0-9_']{1,})(.*)/ ;
    $self->{name} =~ s/\'//g ;

	#形式部分を取得
	$self->{name} =~ /^[A-z]{1,} (([A-Za-z0-9_']{1,}|[A-Za-z0-9_]{1,})(.*))/ ;
	#形式部分を分割
	my @type = split(/_/,$1,2) ;
	#print join("-",@type)."\n" ;
	#称号取得
	#$type[0] =~ s/[0-9']{1,}// ;
    $data = $types->{$type[0]} ;

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
	M1c => "浦賀方 先頭車",
	M2c => "品川方 先頭車",
	M3c => "品川方 先頭車",
	Muc => "浦賀方 先頭車",
	Msc => "品川方 先頭車",
	Mcu => "浦賀方 先頭車",
	Mcs => "品川方 先頭車",
	M2cu => "浦賀方 先頭車",
	M2cs => "品川方 先頭車",
	M2uc => "浦賀方 先頭車",
	M2sc => "品川方 先頭車",
	Tuc => "浦賀方 先頭車",
	Tsc => "品川方 先頭車",
	Tcu => "浦賀方 先頭車",
	Tcs => "品川方 先頭車",
	Mu => "浦賀方 電動車",
	Ms => "品川方 電動車",
	M1 => "品川方 電動車",
	M1u => "浦賀方 電動車",
	M1s => "品川方 電動車",
	M2 => "浦賀方 電動車",
	M2u => "浦賀方 電動車",
	M2s => "品川方 電動車",
	M3 => "浦賀方 電動車",
	Tu => "浦賀方 付随車",
	Ts => "品川方 付随車",
	Tc => "先頭車",
	Mc => "先頭電動車",	
	M => "電動車",
	T => "付随車",
	Tp => "パンタ付 付随車",
	Tps => "品川方 パンタ付 付随車",
	Tpu => "浦賀方 パンタ付 付随車",
	Tp2 => "パンタ付 付随車",
    };

    #$data .= "(".$types_2->{$type[0]}.")";
    if($types_2->{$type[0]}){
	print "Type:".$type[0]." / ".$types_2->{$type[0]}."\n" ;
	$data .= "(".$types_2->{$type[0]}.")";
    }else{
	$data .= "(".$type[0].")";
    }
    return $data ;

    sub Series_Num{#番台取得
	my $nm = shift ;
	my $data = $nm ;
	$nm =~ s/non cooler/非冷房車/ ;
	$nm =~ s/Proto type/試作車/; 
	$nm =~ s/renewal:VVVF custom/VVVF改造更新車/ ;
	$nm =~ s/Keikyu Blue Sky Train/京急 ブルースカイトレイン/ ;
	$nm =~ s/type/タイプ/ ;
	$nm =~ s/SUS/ステンレス車/ ;
	$nm =~ s/Renewal/更新車/i ;
	$nm =~ s/3doors/3ドア車/ ;
	$nm =~ s/2doors/2ドア車/ ;
	$nm =~ s/old color/旧塗装/ ;

	$data = $nm ;

	return $data ;
    }
}

1;
