function checkAll(rRows)
	{
	var selBox = 0;
	for ( i = 0; i<rRows; i++)
		{
		if ( document.forms[0].elements['CheckBox_'+i].checked )
			{
			selBox = 1;
			break;
			}
		}
	if ( selBox == 0 )
		{
		alert('Select atleast one Report to Delete');
		document.returnValue = false;
		}
	else
		{
		document.returnValue = true;
		}
	}
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