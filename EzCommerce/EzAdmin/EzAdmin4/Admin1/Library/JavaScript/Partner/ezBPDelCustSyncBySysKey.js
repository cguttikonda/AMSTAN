 //	var tabHeadWidth=80
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

function delsync()
{
	var selCnt = document.myForm.CheckBox.length;
	if(isNaN(selCnt))
	{
			if ( document.myForm.CheckBox.checked )
			{
				selCnt = 1;
			}
	}
	else
	{
		for ( i = 0; i < selCnt; i++ )
		{
			if ( document.myForm.CheckBox[i].checked )
			{
				selCnt = 1;
				break;
			}
		}
	
	
	}

	if ( selCnt == 0 )
	{
		alert('Select one Partner Function to Delete');
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
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

function funsubmit()
{
	document.myForm.BusinessPartner.options[0].selected=true;
	document.myForm.action="ezBPDelCustSyncBySysKey.jsp";
	document.myForm.submit();
}


function funsubmit1(area)
{
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel" && document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select " +area +" and BussinessPartner");
		return;
	}
	else
	{
		document.myForm.action="ezBPDelCustSyncBySysKey.jsp";
		document.myForm.submit();
	}
	

	/*if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.myForm.action="ezBPDelCustSyncBySysKey.jsp";
		document.myForm.submit();
	}
	*/
}
