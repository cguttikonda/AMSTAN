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
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.ConnectParam.SysNum.value;
	for (var i = 0; i < document.ConnectParam.SysNum.options.length; i++) 
		{
		if (document.ConnectParam.SysNum.options[i].selected)
			{
			mUrl3 = "&index=" + (i-1);
			}
		}
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	if(document.ConnectParam.SysNum.selectedIndex==0)
		{
		alert("Please Select the System.");
		document.ConnectParam.SysNum.focus();
		}
	else
		{
		location.href= mUrl;
		}
	}

function checkAll() 
	{
	var form = document.forms[0]
	for (i = 0; i < form.elements.length; i++) 
		{
		var name = form.elements[i].name;
		if(name.charAt(0) == "*")
			continue;
		if (form.elements[i].type == "text" && form.elements[i].value == "")
			{
			alert("Please fill all the fields.")
			form.elements[i].focus();
			document.returnValue = false;
			break;
			}
		else
			{
			document.returnValue = true;
			}
		}
      	if ( !isInteger(document.ConnectParam.R3SystemNumber.value) )
      		{
          	alert('Numeric value is expected System Number');
          	document.ConnectParam.R3SystemNumber.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.R3Client.value) )
      		{
          	alert('Numeric value is expected for Client/Company');
          	document.ConnectParam.R3Client.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.AutoRetry.value) )
      		{
          	alert('Numeric value is expected here');
          	document.ConnectParam.AutoRetry.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.LogFileSize.value) )
      		{
          	alert('Numeric value is expected Log File');
          	document.ConnectParam.LogFileSize.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.R3Connections.value) )
      		{
          	alert('Numeric value is expected for ERP Connections');
          	document.ConnectParam.R3Connections.focus();
          	document.returnValue = false;
          	return;
      		}
	if ( !(document.ConnectParam.R3Connections.value>0) )
      		{
          	alert('Number of ERP Connection cannot be <=0');
          	document.ConnectParam.R3Connections.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.DBConnections.value) )
      		{
      	    	alert('Numeric value is expected for DB Connections');
          	document.ConnectParam.DBConnections.focus();
          	document.returnValue = false;
	        return;
      		}
      	if ( !isInteger(document.ConnectParam.R3Retrys.value) )
      		{
          	alert('Numeric value is expected Retrys');
          	document.ConnectParam.R3Retrys.focus();
          	document.returnValue = false;
          	return;
      		}
      	if ( !isInteger(document.ConnectParam.DBRetrys.value) )
      		{	
          	alert('Numeric value is expected for DB Retrys');
          	document.ConnectParam.DBRetrys.focus();
          	document.returnValue = false;
          	return;
      		}
	}
