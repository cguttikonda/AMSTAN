function myalert()
	{
	if(document.forms[0].SysNum.selectedIndex==0)
		{
		alert("Please Select a System.")
		document.forms[0].SysNum.focus();
		}
	else
		{
		myurl = document.URL;
		index = myurl.indexOf(".jsp");
	 	newurl = myurl.substring(0, index);

		mUrl1 =  newurl + ".jsp?";

		mUrl2 = "SystemNumber=" + document.forms[0].SysNum.value;

		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
		}
	}		
	
