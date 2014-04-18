function checkdate(m,d,y){
	var err=0
	var psj=0;

	//basic error checking
	if (m<1 || m>12) err = 1
	if (d<1 || d>31) err = 1
	if (y<1900 || y>1980) err = 1
	
	// months with 30 days
	if (m==4 || m==6 || m==9 || m==11){
		if (d==31) err=1
	}

	// february, leap year
	if (m==2){
		// feb
		var g=parseInt(y/4)
		if (isNaN(g)) {
			err=1
		}

		if (d>29) err=1
		if (d==29 && ((f/4)!=parseInt(f/4))) err=1
	}

	if (err==1){
		return false
	}else{
		return true
	}
}