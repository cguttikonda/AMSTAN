function myalert()
{
	if(document.forms[0].SysNum.selectedIndex!=0)
	{
	
		myurl = document.URL;
		index = myurl.indexOf(".jsp");
 		newurl = myurl.substring(0, index);
		mUrl1 =  newurl + ".jsp?";
		mUrl2 = "SystemNumber=" + document.myForm.SysNum.value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
	}
}


