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
			if(document.myForm.interuser.value=="BU")
			{
				document.myForm.action="ezChangeUserData.jsp"
				document.myForm.submit();
			}
			else
			{
				document.myForm.action="ezChangeIntranetUserData.jsp";
				document.myForm.submit();
			}
		}
		else
		{
			alert("Please Select a User To Modify");
			document.returnValue=false
		}
	}
	else
	{
		var ut="";
		
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				count++;
				ut=document.myForm.interuser[i].value;
				document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
				bool=true;
			}
		}
	
	
		if(bool && count==1)
		{
			if(ut=="BU")
			{
				document.myForm.action="ezChangeUserData.jsp"
				document.myForm.submit();
			}
			else
			{
				document.myForm.action="ezChangeIntranetUserData.jsp";
				document.myForm.submit();
			}
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

