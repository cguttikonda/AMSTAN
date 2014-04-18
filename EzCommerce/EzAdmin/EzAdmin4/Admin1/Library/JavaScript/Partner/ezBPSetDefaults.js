
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
	var selCnt = -1;
	var selSys = -1;

	if ( sCnt == 1 )
	{
		if ( document.myForm.SysKey.checked )
		{
			selSys = 0;
			selCnt = 1;
		}
	}
	else
	{
		for(i=0; i<sCnt; i++)
		{
			if ( document.myForm.SysKey[i].checked )
			{
				selSys = i;
				selCnt = 1;
				break;
			}
		} //end for i<sCnt
	} //end if

	if ( selCnt == 1 )
	{
		document.myForm.SoldTo.value = document.myForm.elements['ERPCUST_'+selSys].value;
		document.myForm.area.value = document.myForm.elements['AREA_'+selSys].value;
		document.returnValue = true;
	}
	else
	{
		alert('Select atleast one area to set partner defaults');
		document.returnValue = false;
	}

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

