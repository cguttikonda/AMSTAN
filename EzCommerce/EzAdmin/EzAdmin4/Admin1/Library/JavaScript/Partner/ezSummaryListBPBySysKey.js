
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
	//alert(document.myForm.Area.value);
	//document.myForm.syskey.value=document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value
	document.myForm.action="ezSummaryListBPBySysKey.jsp?from=Search";
	document.myForm.submit();
}



function funDepDefaults()
{
	var wsk=document.myForm.chk1.length;	
	//alert(wsk);
	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BusinessPartner.value=document.myForm.chk1.value;
			document.myForm.action="ezBPSummaryBySysKey.jsp"		
			document.myForm.submit();
		}
		else
		{
			alert("Please Select Partner to Get Independent Defaults");
		}
	}
	else
	{
		var bool=false;
		for(var i=0;i<wsk;i++)
		{
			//alert(document.myForm.chk1[i].checked);
			if(document.myForm.chk1[i].checked==true)
			{
				document.myForm.BusinessPartner.value=document.myForm.chk1[i].value;
				bool=true;
				break;
			}
		
		
		}
	if(bool==true)
	{
		document.myForm.action="ezBPSummaryBySysKey.jsp"		
		document.myForm.submit();
	}
	else
	{
		alert("Please Select Partner to Get dependent Defaults");
	}
	
 }
}

	
	
function ezSearch()
{
	var WebSysKey=document.myForm.WebSysKey[document.myForm.WebSysKey.selectedIndex].value
	//alert(WebSysKey);
	searchstring=showModalDialog('ezSearchDialog.jsp','','center:yes;dialogWidth:25;dialogHeight:16;status:no;minimize:yes')
	document.myForm.searchcriteria.value=searchstring;
	if(searchstring!=null)
	{
		if(searchstring.length!=0)
		{
			funsubmit();
		}
	}
}
