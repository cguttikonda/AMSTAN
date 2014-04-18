
function funDeleteBP()
{
	if(chkDel(document.myForm))
	{
		document.myForm.action="ezDeleteBussPartner.jsp"
		document.myForm.submit();
	}
}

 function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
// 	var OuterdivId1=document.getElementById("OuterBox1Div")
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
		document.myForm.action="ezListBPBySysKey.jsp";
		document.myForm.submit();
	}
}



function funCheckBoxSingleModify(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	var bool=false;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BPDesc.value=document.myForm.BPDesch.value;
			document.myForm.action="ezChangeBPInfo.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select The Partner To Modify");
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				document.myForm.BPDesc.value=document.myForm.BPDesch[i].value;
				bool=true;
				break;
			}
		}


		if(bool)
		{

			document.myForm.action="ezChangeBPInfo.jsp"
			document.myForm.submit();
		}
		else
		{

			alert("Please Select The Partner To Modify");
		}
	}
	}
	else
 	{
 		alert("Please Select "+ area +".")
 	}

}

function funCheckBoxSingleMPS(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	var bool=false;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BPDesc.value=document.myForm.BPDesch.value;
			document.myForm.action="ezChangeBPSystems.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select The Partner To Modify");
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				document.myForm.BPDesc.value=document.myForm.BPDesch[i].value;
				bool=true;
				break;
			}
		}


		if(bool)
		{
			document.myForm.action="ezChangeBPSystems.jsp"
			document.myForm.submit();
		}
		else
		{

			alert("Please Select The Partner To Modify");
		}
	}
	}
	else
 	{
 		alert("Please Select "+ area +".")
 	}
}


function funLTrim(sValue)
	{
	var nLength=sValue.length;
	var nStart=0;
	while ((nStart < nLength) && (sValue.charAt(nStart) == " "))
		{
			nStart=nStart+1;
		}

	if (nStart==nLength)
		{
			sValue="";
		}
	else
		{
			sValue=sValue.substr(nStart,nLength-nStart);
		}

	return sValue;

	}

function funRTrim(sValue)
	{
	var nLength=sValue.length;
	if (nLength==0)
		{
		sValue="";
		}
	else
		{
		var nStart=nLength-1;
		while ((nStart > 0) && (sValue.charAt(nStart)==" "))
			{
			nStart=nStart-1;
			}
		if (nStart==-1)
			{
			sValue="";
			}
		else
			{
			sValue=sValue.substr(0,nStart+1);
			}
		}

		return sValue;
	}
	function funTrim(sValue)
	{
		sValue=funLTrim(sValue);
		sValue=funRTrim(sValue);
		return sValue;
	}
	function chkSubmit()
	{
		s=document.myForm.searchUserId.value
		s=funTrim(s);
		if(s.length==0)
		{
			alert("Enter Partner Name  to Search");
			document.myForm.searchUserId.value=s
			return false;
		}
		else
		{
			document.myForm.searchUserId.value=s
			return true;
		}
	}


function funSummary(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var wsk=document.myForm.chk1.length;
	//alert(wsk);
	if (isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BusinessPartner.value=document.myForm.chk1.value;
			document.myForm.action="ezBPSummaryBySysKey.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select Partner to view Summary");
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
		alert("Please Select Partner to view Summary");
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
				document.myForm.action="ezListBPBySysKey.jsp";
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
		if((searchstring.length!=0)&&(searchstring != null))
		{
			if(document.myForm.WebSysKey.selectedIndex != 0)
			{
				document.myForm.action="ezListBPBySysKey.jsp?from=Search";
				document.myForm.submit();
			}
		}
	}
}
