
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
		document.myForm.action="ezSynchListBPBySysKey.jsp";
		document.myForm.submit();
	}
}



function funSynch(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var wsk=document.myForm.chk1.length;

	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked)
		{

			//document.myForm.BusinessPartner.value=document.myForm.chk1.value;
			var chkKey 	= document.myForm.chk1.value
			var chkKeyVal 	= chkKey.split("/");
			
			document.myForm.BusinessPartner.value=chkKeyVal[0];
			document.myForm.BPsyskey.value=chkKeyVal[1];
			
			document.myForm.action="ezBPCustSyncBySysKey.jsp"
			document.myForm.submit();

		}
		else
		{
			alert("Please Select Partner to synchronize");

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
				//document.myForm.BusinessPartner.value=document.myForm.chk1[i].value;
				var chkKey 	= document.myForm.chk1[i].value
				var chkKeyVal 	= chkKey.split("/");

				//alert(chkKeyVal[0]+"----"+chkKeyVal[1]);
				document.myForm.BusinessPartner.value=chkKeyVal[0];
				document.myForm.BPsyskey.value=chkKeyVal[1];
				
				bool=true;
				break;
			}


		}
	if(bool==true)
	{
		document.myForm.action="ezBPCustSyncBySysKey.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Please Select Partner to synchronize");
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
				document.myForm.action="ezSynchListBPBySysKey.jsp";
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
				document.myForm.action="ezSynchListBPBySysKey.jsp?from=Search";
				document.myForm.submit();
			}
		}
	}
}
