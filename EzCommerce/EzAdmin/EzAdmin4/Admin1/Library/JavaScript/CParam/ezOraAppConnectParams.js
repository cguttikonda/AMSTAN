function isDigit (c)
{
	return ((c >= "0") && (c <= "9"))
}

function isInteger (s)
{
	var i;
    	// Search through string's characters one by one
    	// until we find a non-numeric character.
    	// When we do, return false; if we don't, return true.
	for (i = 0; i < s.length; i++)
    	{
        	// Check that current character is number.
        	var c = s.charAt(i);
        	if (!isDigit(c)) return false;
    	}
	// All characters are numbers.
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
		for (var i = 0; i < document.myForm.SysNum.options.length; i++) 
		{
			if (document.myForm.SysNum.options[i].selected)
			{
				mUrl3 = "&index=" + (i-1);
			}
		}
		mUrl =  mUrl1 + mUrl2 + mUrl3;
		location.href= mUrl;
	}
}
	
function checkAll() 
{
	if(document.forms[0].SysNum.selectedIndex==0)
	{
		alert("Please Select System.");
		document.forms[0].SysNum.focus();				
		document.returnValue=false;
	}	
	else
	{	
		if(document.myForm.GroupName.value=="")
		{
			alert("please Enter Group Name");		
			document.returnValue=false;
			document.myForm.GroupName.focus();
			return;
		}
		if(document.myForm.R3MessageServer.value=="")
		{
			alert("Please Enter JDBC Driver");
			document.returnValue=false;
			document.myForm.R3MessageServer.focus();
			return;
		}
		if(document.myForm.R3SystemName.value=="")
		{
			alert("Please Enter Connection URL");
			document.returnValue=false;
			document.myForm.R3SystemName.focus();
			return;
		}
		if(document.myForm.R3UserID.value=="")
		{
			alert("Please Enter ERP UserID");
			document.returnValue=false;
			document.myForm.R3UserID.focus();
			return;
		}
		if(document.myForm.R3Password.value=="")
		{
			alert("Please Enter ERP Password");
			document.returnValue=false;
			document.myForm.R3Password.focus();
			return;
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
}
	

