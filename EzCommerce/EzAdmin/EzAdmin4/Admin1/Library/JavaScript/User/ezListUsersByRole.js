//var tabHeadWidth=80
 function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 //	var OuterdivId1=document.getElementById("OuterBox1Div")
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
		document.myForm.action="ezListAllUsersBySysKey.jsp";
		document.myForm.submit();
	}
}


function funCheckBoxSingleModify()
{
	var len=document.myForm.chk1.length;
	var count=0;
	var bool=false;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			count++;
			document.myForm.BusinessUser.value=document.myForm.chk1.value;
			var val=eval("document.myForm.U"+document.myForm.chk1.value)
			var val1=val.value
			if(val1=="2")
				document.myForm.action="ezChangeIntranetUserData.jsp"
			else
				document.myForm.action="ezChangeUserData.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select a User To Modify");
			document.returnValue=false
		}
	}
	else
	{
		var valA="";
		for(i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				count++;
				document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
				bool=true;
				
				myString="document.myForm.U"+document.myForm.chk1[i].value;	
				valA=eval(myString)
			}
		}
	//alert("after loop")
		if(bool && count==1)
		{
			if(valA.value=="2")
				document.myForm.action="ezChangeIntranetUserData.jsp"
			else
				document.myForm.action="ezChangeUserData.jsp"
			document.myForm.submit();
		}
		else
		{
			if(count>1)
			{
				alert("Please Select only one User To Modify");
				document.returnValue=false
			}
			else
			{
				alert("Please Select a User To Modify");
				document.returnValue=false
			}
		}
	}
}

function funCheckBoxSingleDelete()
{
	var len=document.myForm.chk1.length;
	var bool=false;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			document.myForm.BusinessUser.value=document.myForm.chk1.value;
			document.myForm.action="ezDeleteUser.jsp"
			document.myForm.submit();
		}
		else
		{
			alert("Please Select The Users To Delete ");
			return false;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
				bool=true;
			}
		}
	
	
		if(bool)
		{
			document.myForm.action="ezDeleteUser.jsp"
			document.myForm.submit();
		}
		else
		{
			
			alert("Please Select The Users To Delete");	
			return false;
		}
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
		var nStart=nLength;
		
		while ((nStart > 0) && (sValue.charAt(nStart)==" "))
		{
			nStart=nStart-1;
		}
	
		if (nStart==0)
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