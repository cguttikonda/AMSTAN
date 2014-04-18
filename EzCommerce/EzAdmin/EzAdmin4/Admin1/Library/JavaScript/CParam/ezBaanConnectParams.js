function isDigit (c)
{
	return ((c >= "0") && (c <= "9"))
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
    	return true;
}
function placeFocus() 
{
	if (document.forms.length > 0) 
	{
		var field = document.forms[0];
		for (i = 0; i < field.length; i++) 
		{
			if (field.elements[i].name == "GroupName") 
			{
		 		document.forms[0].elements[i].focus();
				break;
 			}
 		}
	}
}
function myalert()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.myForm.SysNum.value;
	for (var i = 0; i < document.myForm.SysNum.options.length; i++) 
	{
		if (document.myForm.SysNum.options[i].selected)
		{
			mUrl3 = "&index=" + (i-1);
		}
	}
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	if(document.myForm.SysNum.selectedIndex!=0)
	{
		location.href= mUrl;
	}
}
function checkAll() 
{
	if(document.myForm.GroupName.value=="")
	{
		alert("please Enter Group Name");		
		document.returnValue=false;
		document.myForm.GroupName.focus();
		return;
	}
	if(document.myForm.R3Host.value=="")
	{
		alert("Please Enter ERP Host IP");
		document.returnValue=false;		
		document.myForm.R3Host.focus();
		return;
	}
	if(document.myForm.R3MessageServer.value=="")
	{
		alert("Please Enter B.S.E Path ");
		document.returnValue=false;
		document.myForm.R3MessageServer.focus();
		return;
	}
	if(document.myForm.R3SystemNumber.value=="")
	{
		alert("Please Enter SystemNumber");
		document.returnValue=false;
		document.myForm.R3SystemNumber.focus()
	}
	if(document.myForm.R3Client.value=="")
	{
		alert("Please Enter Client");
		document.returnValue=false;
		document.myForm.R3Client.focus();
	}
	if(document.myForm.R3UserID.value=="")
	{
		alert("Please Enter User Id");
		document.returnValue=false;
		document.myForm.R3UserID.focus();
	}
      	if ( !isInteger(document.myForm.R3SystemNumber.value) )
	{
          	alert('Numeric value is expected System Number');
          	document.myForm.R3SystemNumber.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.R3Client.value) )
	{
          	alert('Numeric value is expected for Client/Company');
          	document.myForm.R3Client.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.AutoRetry.value) )
	{
          	alert('Numeric value is expected here');
          	document.myForm.AutoRetry.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.LogFileSize.value) )
	{
          	alert('Numeric value is expected Log File');
          	document.myForm.LogFileSize.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.R3Connections.value) )
	{
          	alert('Numeric value is expected for ERP Connections');
          	document.myForm.R3Connections.focus();
          	document.returnValue = false;
          	return;
	}
	if ( !(document.myForm.R3Connections.value>0) )
	{
          	alert('Number of ERP Connection cannot be <=0');
          	document.myForm.R3Connections.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.DBConnections.value) )
	{
      	    	alert('Numeric value is expected for DB Connections');
          	document.myForm.DBConnections.focus();
          	document.returnValue = false;
	        return;
	}
      	if ( !isInteger(document.myForm.R3Retrys.value) )
	{
          	alert('Numeric value is expected Retrys');
          	document.myForm.R3Retrys.focus();
          	document.returnValue = false;
          	return;
	}
      	if ( !isInteger(document.myForm.DBRetrys.value) )
	{	
          	alert('Numeric value is expected for DB Retrys');
          	document.myForm.DBRetrys.focus();
          	document.returnValue = false;
          	return;
	}
      	document.returnValue = true;
}