
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
function funFocus()
{
	if(document.myForm.WebSysKey!=null)
		document.myForm.WebSysKey.focus()
}

function funsubmit1(area)
{
	/*if(document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel" )
	{
		alert("Please Select "+area);
		return;
	}
	*/
	if(document.myForm.WebSysKey.selectedIndex != 0)
	{
		//document.myForm.searchcriteria.value="A*";
		document.myForm.action="ezDefaultsListAllUsersBySysKey.jsp";
		document.myForm.submit();
	}
}

function funDepAuth(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var wsk=document.myForm.chk1.length;
	//alert(wsk);
	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			//document.myForm.BusUser.value=document.myForm.chk1.value;
			var chkKey 	= document.myForm.chk1.value
			var chkKeyVal 	= chkKey.split("/");
			//alert(chkKey+"------"+chkKeyVal);						
			document.myForm.BusUser.value=chkKeyVal[0];
			document.myForm.BPsyskey.value=chkKeyVal[1];
			
			document.myForm.action="ezUserDefaultsListBySysKey.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select User to Get Dependent Defaults");
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
				//document.myForm.BusUser.value=document.myForm.chk1[i].value;
				var chkKey 	= document.myForm.chk1[i].value
				var chkKeyVal 	= chkKey.split("/");
				//alert(chkKey+"------"+chkKeyVal);						
				document.myForm.BusUser.value=chkKeyVal[0];
				document.myForm.BPsyskey.value=chkKeyVal[1];
				
				
				bool=true;
				break;
			}


		}
	if(bool==true)
	{
		document.myForm.action="ezUserDefaultsListBySysKey.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Please Select User to Get Dependent Defaults");
	}
 }
 }
 else
 {
 	alert("Please Select "+ area +".")
 }
}

function funInDepAuth(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var wsk=document.myForm.chk1.length;
	//alert(wsk);
	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			//document.myForm.BusUser.value=document.myForm.chk1.value;
			var chkKey 	= document.myForm.chk1.value
			var chkKeyVal 	= chkKey.split("/");
			//alert(chkKey+"------"+chkKeyVal);						
			document.myForm.BusUser.value=chkKeyVal[0];
			document.myForm.BPsyskey.value=chkKeyVal[1];
			
			document.myForm.action="ezUserOnlyDefaultsListBySysKey.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select User to Get Independent Defaults");
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
				//document.myForm.BusUser.value=document.myForm.chk1[i].value;
				
				var chkKey 	= document.myForm.chk1[i].value
				var chkKeyVal 	= chkKey.split("/");
				//alert(chkKey+"------"+chkKeyVal);						
				document.myForm.BusUser.value=chkKeyVal[0];
				document.myForm.BPsyskey.value=chkKeyVal[1];
				
				bool=true;
				break;
			}


		}
	if(bool==true)
	{
		document.myForm.action="ezUserOnlyDefaultsListBySysKey.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Please Select User to Get Independent Defaults");
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
				document.myForm.action="ezDefaultsListAllUsersBySysKey.jsp";
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
			document.myForm.action="ezDefaultsListAllUsersBySysKey.jsp?from=Search";
			document.myForm.submit();

		}
	}
}
function ezSearchBySoldTo()
{
	var WebSysKey=document.myForm.WebSysKey[document.myForm.WebSysKey.selectedIndex].value
	partnerValue=showModalDialog('ezSearchDialogBySoldTo.jsp','','center:yes;dialogWidth:25;dialogHeight:16;status:no;minimize:yes')
	document.myForm.partnerValue.value=partnerValue;
	if(partnerValue!=null)
	{
		if(partnerValue.length!=0)
		{
			document.myForm.action="ezDefaultsListAllUsersBySysKey.jsp";
			document.myForm.submit();

		}
	}
}