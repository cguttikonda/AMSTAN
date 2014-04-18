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


function funsubmit1(area)
{
	if(document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel" )
	{
		alert("Please Select "+area);
		return;
	}
	else
	{
		document.myForm.action="ezCopyAllUsersBySysKey.jsp";
		document.myForm.submit();
	}
}

function funDepAuth()
{
	var wsk=document.myForm.chk1.length;	
	//alert(wsk);
	if(isNaN(wsk))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BusUser.value=document.myForm.chk1.value;
			document.myForm.action="ezCopyUserBySysKey.jsp"		
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
				document.myForm.BusUser.value=document.myForm.chk1[i].value;
				bool=true;
				break;
			}
		
		
		}
	if(bool==true)
	{
		document.myForm.action="ezCopyUserBySysKey.jsp"		
		document.myForm.submit();
	}
	else
	{
		alert("Please Select User to Get Dependent Defaults");
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
			document.myForm.action="ezCopyAllUsersBySysKey.jsp?from=Search";
			document.myForm.submit();
			
		}
	}
}
