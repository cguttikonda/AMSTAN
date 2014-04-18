 
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


function checkAll()
{
	var len=document.myForm.SysKey.length;
	var count=0;
	if(isNaN(len))
	{
		if(document.myForm.SysKey.checked)
		{
			//alert(document.myForm.ERPCUST.value);
			document.myForm.SoldTo.value = document.myForm.ERPCUST.value;
			document.myForm.area.value = document.myForm.AREA.value;
			document.returnValue = true;
			return;
			
		}
		else
		{
			alert('Select atleast one area to set partner defaults');
			document.returnValue = false;		
			return;
		}	
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.SysKey[i].checked)
			{
				if(document.myForm.BusinessPartner.selectedIndex==0)
				{
					document.returnValue=false;
					return;
				}
				else
				{
					count++;
					document.myForm.SoldTo.value = document.myForm.ERPCUST[i].value;
					document.myForm.area.value = document.myForm.AREA[i].value;
					document.returnValue = true;
					return;
				}
			}
			else
			{
				document.returnValue=false;	
			
			}
		}
		if(count==0)
		{
			alert('Select atleast one area to set partner defaults');
			document.returnValue=false;
		}
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



function funsubmit()
{
	document.myForm.BusinessPartner.options[0].selected=true;
	document.myForm.action="ezBPSetDefaultsBySysKey.jsp";
	document.myForm.submit();
}


function funsubmit1(area)
{
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel" && document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select "+area+" and BussinessPartner");
		return;
	}

	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.myForm.action="ezBPSetDefaultsBySysKey.jsp";
		document.myForm.submit();
	}

}

