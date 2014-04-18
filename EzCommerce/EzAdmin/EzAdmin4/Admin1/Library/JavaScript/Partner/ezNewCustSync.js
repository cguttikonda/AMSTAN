function myalert()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
        mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
		ch = inputStringTrim.charAt(x);
 		if ((ch != " ") || (lastCh != " "))
 		{
 			fixedTrim += ch;
 		}
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim
}


/*function checkAll(arTitle)
{
	
	var len=document.myForm.ECUST.length;
	if(isNaN(len))
	{
		var cVal=document.myForm.NonBaseERPSoldTo.value;
		cVal=trim(cVal);
		if(cVal=="")
		{
			alert('Please enter Sold To Party value');
			document.returnValue = false;
			document.myForm.NonBaseERPSoldTo.focus();
			return;			
		}
		else
		{
			if ( document.myForm.ECUST.value == cVal )
			{
				alert(arTitle+' ' +cVal+' is already synchronized\nTry a different one');
				document.myForm.NonBaseERPSoldTo.focus();
				document.returnValue = false;
				return;
			}
			else
			{
				document.returnValue = true;
			}
		}
	}
	else
	{
		var cVal=document.myForm.NonBaseERPSoldTo.value;
		cVal=trim(cVal);
		if(cVal=="")
		{
			alert('Please enter Sold To Party value');
			document.returnValue = false;
			document.myForm.NonBaseERPSoldTo.focus();
			return;			
		}
		else
		{
			for ( i = 0; i < len; i++)
			{
				if ( document.myForm.ECUST[i].value == cVal )
				{
					alert(arTitle +cVal+' is already synchronized\nTry a different one');
					document.myForm.NonBaseERPSoldTo.focus();
					document.returnValue = false;
					return;
				}
				else
				{
					document.returnValue = true;
					return;
				}		
			}				
		}
	
		
	}
}*/

function checkAll(partyType)
{
	var cCnt = document.myForm.CheckCount.value;
	var len=document.myForm.ECUST.length;
	if(isNaN(len))
	{
		var cVal=document.myForm.NonBaseERPSoldTo.value;
		cVal=trim(cVal);
		if(cVal=="")
		{
			alert("Please enter "+partyType+" To Party value");
			document.returnValue = false;
			document.myForm.NonBaseERPSoldTo.focus();
			return;			
		}
		else
		{
			cVal = cVal.toUpperCase();
			for ( i = 0; i < cCnt; i++)
			{
				var t1=document.myForm.ECUST[i].value
				var t2=cVal
				var spaces="000000000000";
				
				if(t1.length<10)
				{
					
					t1=spaces.substring(0,10-t1.length) + t1;
				}
				if(t2.length<10)
				{			
					t2=spaces.substring(0,10-t2.length) + t2;
				}		
				if (t1 == t2 )
				{
					doReSynch=showModalDialog('ezResynch.jsp',cVal,'center:yes;dialogWidth:25;dialogHeight:20;status:no;minimize:yes')
					//doReSynch= confirm('<%=arTitle%> '+cVal+' is already synchronized. \n\n\nIf you want Re-Synchronize click on OK otherwise clik on cancel')
					if(doReSynch=="Yes")
					{
						document.myForm.ReSynchFlag.value="Y"
						document.returnValue = true;
						break;			
					}
					else
					{
						//alert('<%=arTitle%> '+cVal+' is already synchronized\nTry a different one');
						document.myForm.NonBaseERPSoldTo0.focus();
						document.returnValue = false;
						break;
					}
				}
				else
				{
					document.returnValue = true;
				}
		
			}
		}
	}
	else
	{
		var cVal=document.myForm.NonBaseERPSoldTo.value;
		cVal=trim(cVal);
		if(cVal=="")
		{
			alert("Please enter "+partyType+" To Party value");
			document.returnValue = false;
			document.myForm.NonBaseERPSoldTo.focus();
			return;			
		}
		else
		{
			cVal = cVal.toUpperCase();
			for ( i = 0; i < cCnt; i++)
			{
				var t1=document.myForm.ECUST[i].value
				var t2=cVal
				var spaces="000000000000";
				
				if(t1.length<10)
				{
					
					t1=spaces.substring(0,10-t1.length) + t1;
				}
				if(t2.length<10)
				{			
					t2=spaces.substring(0,10-t2.length) + t2;
				}		
				if (t1 == t2 )
				{
					doReSynch=showModalDialog('ezResynch.jsp',cVal,'center:yes;dialogWidth:25;dialogHeight:20;status:no;minimize:yes')
					//doReSynch= confirm('<%=arTitle%> '+cVal+' is already synchronized. \n\n\nIf you want Re-Synchronize click on OK otherwise clik on cancel')
					if(doReSynch=="Yes")
					{
						document.myForm.ReSynchFlag.value="Y"
						document.returnValue = true;
						break;			
					}
					else
					{
						//alert('<%=arTitle%> '+cVal+' is already synchronized\nTry a different one');
						document.myForm.NonBaseERPSoldTo.focus();
						document.returnValue = false;
						break;
					}
				}
				else
				{
					document.returnValue = true;
				}
		
			}
		}
	}
}



function changeArea()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = ""; 
	mUrl3 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl4 = "&CatalogArea=" + document.myForm.SysKey.value +"&Area="+document.myForm.Area.value;
	mUrl =  mUrl1 + mUrl2+mUrl3+mUrl4+"&FUNCTION="+document.myForm.FUNCTION.value+"&WebSysKey="+document.myForm.SysKey.value;
	location.href= mUrl;
}

function syschange()
{
	//myhost = window.location.host;
	//mUrl1 =  "http://" + myhost + "/Admin/Admin1/JSPs/Partner/ezNewCustSync.jsp?";
	//mUrl2 = "SystemNumber=" + document.myForm.NonBaseERP.value + "&";
	//mUrl3 = "BusinessPartner=" + document.myForm.BusPartner.value;
	//mUrl =  mUrl1 + mUrl2 + mUrl3;
	//location.href= mUrl;

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.myForm.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3+"&FUNCTION="+document.myForm.FUNCTION.value;
	location.href= mUrl;

}
