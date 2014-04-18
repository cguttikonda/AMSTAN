//var tabHeadWidth=80
function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}

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

function checkAll(sCnt)
{
	var selCnt = 0;
	var selSys = 0;
	if ( sCnt == 1 )
	{
		if ( document.myForm.SysKey.checked )
		{
			selSys = 0;
			selCnt = -1;
		}
	}
	else
	{
		for(i=0; i<sCnt; i++)
		{
			if ( document.myForm.SysKey[i].checked )
			{
				selSys = i;
				if ( trim(document.myForm.elements['ERPCUST_'+i].value) == '')
				{
					selCnt = i;
					break;
				}
				selCnt = -1;
				break;
			} //end if
		} //end for
	} //end if

	if ( selCnt == 0 )
	{
		alert('Select one area to synchronize');
		document.returnValue = false;
	}
	else if ( selCnt != -1 )
	{
		alert('Enter Valid ERP <%=cTitle%>');
		document.returnValue = false;
		document.myForm.elements['ERPCUST_'+selCnt].focus();
	}
	else
	{
		/** Commented by Venkat on 5/23/2001 - 4 PM **/
		var tCount = document.myForm.TotalCount.value;
		var checkText = document.myForm.elements['ERPCUST_'+selSys].value;
		for( i=0; i < tCount; i++)
		{
			var ezcText = document.myForm.elements['ERPCUST_'+i].value

			var ezcArea = document.myForm.elements['AREA_'+selSys].value;
			var cEzcArea = document.myForm.elements['AREA_'+i].value;


			//checking selected Area
			//eliminating selected text
			//checking TextBox Value
			if ( ezcArea == cEzcArea && i !=selSys && ezcText == checkText )
			{
				alert('ERP <%=cTitle%> '+checkText+' is already synchronized for this area\nTry a different ERP <%=cTitle%> Number');
				document.returnValue = false;
				document.myForm.elements['ERPCUST_'+selSys].value='';
				document.myForm.elements['ERPCUST_'+selSys].focus();
				break;
			}
			else
			{
				document.returnValue = true;
			}
		}
		/**/
		//document.returnValue = true; //Added on 5/23/2001 - 4 PM
	}

}

function addcust(fnc)
{
	document.myForm.action = "ezNewCustSync.jsp?BusinessPartner="+document.myForm.BusPartner.value;
	document.myForm.submit();
}


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

function syschange()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.myForm.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3;
	location.href= mUrl;

}

function custalert()
{

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
      mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;

	mUrl =  mUrl1 + mUrl2+"&FUNCTION=" + document.myForm.FUNCTION.value;

	location.href= mUrl;

}

function custsyschange()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemNumber=" + document.myForm.NonBaseERP.value + "&";
	mUrl3 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3;
	location.href= mUrl;
}
