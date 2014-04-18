
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
	if(document.myForm.WebSysKey.selectedIndex != 0)
	{
		//document.myForm.searchcriteria.value="A*";
		document.myForm.action="ezDeleteSynchListBPBySysKey.jsp";
		document.myForm.submit();
	}	
}



function funDepDefaults(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var wsk=document.myForm.chk1.length;

	//alert(wsk);
	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BusinessPartner.value=document.myForm.chk1.value;

			document.myForm.action="ezBPDelCustSyncBySysKey.jsp"
			document.myForm.submit();

		}
		else
		{
			alert("Please Select Partner to Delete Synchronization");
			return false;
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
		document.myForm.action="ezBPDelCustSyncBySysKey.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Please Select Partner to Delete Synchronization");
		return false;
	}
 }
 }
 else
 {
 	alert("Please Select "+ area +".")
 }
}

function ezAlphabet(alphabet,areaLabel)
{
	var WebSysKey=document.myForm.WebSysKey[document.myForm.WebSysKey.selectedIndex].value
	searchstring=alphabet+"*";
	if(searchstring=="All*")
		document.myForm.searchcriteria.value="";
	else
		document.myForm.searchcriteria.value=searchstring;
	if(searchstring!=null)
	{
		if(searchstring.length!=0)
		{
			if(document.myForm.WebSysKey.selectedIndex != 0)
			{
				document.myForm.action="ezDeleteSynchListBPBySysKey.jsp";
				document.myForm.submit();
			}
			else
			{
				alert("Please Select "+areaLabel);
			}
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
			if(document.myForm.WebSysKey.selectedIndex != 0)
			{
				document.myForm.action="ezDeleteSynchListBPBySysKey.jsp?from=Search";
				document.myForm.submit();
			}
		}
	}
}
