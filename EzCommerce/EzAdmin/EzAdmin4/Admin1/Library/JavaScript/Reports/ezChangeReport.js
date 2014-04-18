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
		mUrl2 = "SystemNumber=" + document.myForm.SysNum.value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
		}
	}
function changeReport()
	{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "ReportName=" + document.myForm.RepName.value + "&";
	mUrl3 = "SystemNumber=" + document.myForm.SysNum.value;
	mUrl =  mUrl1 + mUrl2+ mUrl3;
	location.href= mUrl;
	}
function checkSelect()
	{
	var pCount = 0;
	var selCount = 0;
	pCount = document.myForm.TotalCount.value;
	for ( i = 0 ; i < pCount; i++ ) 
		{
		if(document.myForm.elements['SetFlag_' + i].checked)
			{
			selCount = selCount + 1;
			}
		}
	if(selCount>1)
		{
		alert("Only one parameter can be selected");
		document.returnValue = false;
		}
	else
		{
		document.returnValue = true;
		}
	}
