function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessUser=" + document.UserDef.BusUser.value;
		mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

