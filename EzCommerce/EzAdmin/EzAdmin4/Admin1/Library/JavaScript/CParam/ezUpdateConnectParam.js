function isDigit (c)
	{
	return ((c >= "0") && (c <= "9"))
	}

function UpdateAndTest()
	{
	checkAll();
	document.myForm.action="ezUpdateSaveAndTestConnectParam.jsp";
	return true;
	}
function isInteger (s)
	{
	var i;
    	for (i = 0; i < s.length; i++)
    		{
        	// Check that current character is number.
        	var c = s.charAt(i);
        	if (!isDigit(c)) return false;
    		}
    	// All characters are numbers.
    	return true;
	}

function myalert()
	{
	if(document.forms[0].SysNum.selectedIndex==0)
		{
		alert("Please Select System.");
		document.forms[0].SysNum.focus();				
		document.returnValue=false;
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

function changeGroup()
	{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.myForm.SysNum.value;
	mUrl3 = "&GrpID=" + document.myForm.GroupID.value;
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	location.href= mUrl;
	}

