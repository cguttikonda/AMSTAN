 
// var tabHeadWidth=80
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

function funsubmit()
{
 
         document.myForm.BusinessPartner.options[0].selected=true;
	 document.myForm.action="ezBPCustSyncBySysKey.jsp";
	 document.myForm.submit();
       	 
}

function funsubmit1(areaLabel)
{
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel" && document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select "+areaLabel+" and BussinessPartner");
		return;
	}


	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.myForm.action="ezBPCustSyncBySysKey.jsp";
		document.myForm.submit();
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
	var cnt=0;
	var len=document.myForm.SysKey.length;
	if(isNaN(len))
	{
		if(document.myForm.SysKey.checked==true)
		{
			if(document.myForm.BusinessPartner.selectedIndex==0)
			{
				alert("Please Select the Bussiness Partner");
				document.returnValue=false;
				return;
			}
			else
			{
				document.returnValue=true;
				return;
			}
		}
		else
		{
			alert("Please Select one ERP System to Synchronize");
			document.returnValue=false;
			return;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.SysKey[i].checked==true)
			{
				
				if(document.myForm.BusinessPartner.selectedIndex==0)
				{
					alert("Please Select the Bussiness Partner");
					document.returnValue=false;
					return;
				}
				else
				{
					cnt++;
					document.returnValue=true;
					return;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select one ERP System to Synchronize");
			document.returnValue=false;
			return;
		}
	}

}




function addcust(fnc)
{
		document.myForm.action = "ezNewCustSync.jsp?BusinessPartner="+document.myForm.BusinessPartner.value;
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
	mUrl3 = "BusinessPartner=" + document.myForm.BusinessPartner.value;
	mUrl =  mUrl1 + mUrl2+mUrl3;
	location.href= mUrl;
}

