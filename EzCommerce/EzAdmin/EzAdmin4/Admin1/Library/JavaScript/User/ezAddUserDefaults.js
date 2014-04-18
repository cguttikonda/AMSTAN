function syskeychange(){


myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemKey=" + document.myForm.SysKey.value + "&";
	mUrl3 = "BusinessUser=" + document.myForm.BusUser.value;
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	location.href= mUrl;
}
