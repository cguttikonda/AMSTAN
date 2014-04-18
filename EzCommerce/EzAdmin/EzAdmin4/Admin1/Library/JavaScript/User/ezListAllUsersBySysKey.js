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

function bodyInit()
{
	scrollInit()
	if(document.myForm.WebSysKey != null)
		document.myForm.WebSysKey.focus()
}

function funsubmit1(area)
{
	if(document.myForm.WebSysKey.selectedIndex != 0)
	{
		//document.myForm.searchcriteria.value="A*";
		document.myForm.action="ezListAllUsersBySysKey.jsp";
		document.myForm.submit();
	}
}

function funCheckBoxSingleModify(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	var count=0;
	var bool=false;
	var userType = "";
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			count++;
			
			//document.myForm.BusinessUser.value=document.myForm.chk1.value;
			var chkKey 	= document.myForm.chk1.value
			var chkKeyVal 	= chkKey.split("/");
			//alert(chkKey+"------"+chkKeyVal);						
			document.myForm.BusinessUser.value=chkKeyVal[0];
			document.myForm.BPsyskey.value=chkKeyVal[1];
						
			userType = document.myForm.utype.value;
			if(userType==3)
			{
				document.myForm.action="ezChangeUserData.jsp"
				document.myForm.submit();
			}
			else
			{
				document.myForm.action="ezChangeIntranetUserData.jsp"
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
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				count++;
				
				//document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
				var chkKey 	= document.myForm.chk1[i].value
				var chkKeyVal 	= chkKey.split("/");
				//alert(chkKey+"------"+chkKeyVal);						
				document.myForm.BusinessUser.value=chkKeyVal[0];
				document.myForm.BPsyskey.value=chkKeyVal[1];
			
				
				userType = document.myForm.utype[i].value;
				bool=true;
			}
		}


		if(bool && count==1)
		{
			if(userType==3)
			{
				document.myForm.action="ezChangeUserData.jsp"
				document.myForm.submit();
			}
			else
			{
				document.myForm.action="ezChangeIntranetUserData.jsp"
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
 	else
 	{
 		alert("Please Select "+ area +".")
 	}
}






function funCheckBoxSingleDelete(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	count=0;
	if(document.myForm.chk1.checked)
	{
	    //document.myForm.BusinessUser.value=document.myForm.chk1.value;
	    var chkKey 	= document.myForm.chk1.value
	    var chkKeyVal 	= chkKey.split("/");
	    //alert(chkKey+"------"+chkKeyVal);						
	    document.myForm.BusinessUser.value=chkKeyVal[0];
	    document.myForm.BPsyskey.value=chkKeyVal[1];
	    
	    count++;
	}
	for(i=0;i<len;i++)
	{
	   if(document.myForm.chk1[i].checked)
	   {
	       //document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
	       var chkKey 	= document.myForm.chk1[i].value
	       var chkKeyVal 	= chkKey.split("/");
	       //alert(chkKey+"------"+chkKeyVal);						
	       document.myForm.BusinessUser.value=chkKeyVal[0];
	       document.myForm.BPsyskey.value=chkKeyVal[1];
	       
	       count++;
	   }
	}
	if(count==0)
	{
	    alert("Please Select The Users To Delete")
	}

	else
	{
	     document.myForm.action="ezDeleteUser.jsp"
	     document.myForm.submit();
	}
	}
 	else
 	{
 		alert("Please Select "+ area +".")
 	}
}

function funCheckBoxSingleCopyUser(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	count=0;
	if(document.myForm.chk1.checked)
	{
	    //document.myForm.BusinessUser.value=document.myForm.chk1.value;
	    var chkKey 	= document.myForm.chk1.value
	    var chkKeyVal 	= chkKey.split("/");
	    //alert(chkKey+"------"+chkKeyVal);						
	    document.myForm.BusinessUser.value=chkKeyVal[0];
	    document.myForm.BPsyskey.value=chkKeyVal[1];
	    
	    count++;
	}
	for(i=0;i<len;i++)
	{
	   if(document.myForm.chk1[i].checked)
	   {
	       //document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
	        var chkKey 	= document.myForm.chk1[i].value
	        var chkKeyVal 	= chkKey.split("/");
	        //alert(chkKey+"------"+chkKeyVal);						
	       	document.myForm.BusinessUser.value=chkKeyVal[0];
	        document.myForm.BPsyskey.value=chkKeyVal[1];
	       
	       	count++;
	   }
	}
	if(count==0)
	{
	    alert("Please Select the User to Copy")
	}

	else
	{
	     document.myForm.action="ezCopyUserBySysKey.jsp"
	     document.myForm.submit();
	}
	}
 	else
 	{
 		alert("Please Select "+ area +".")
 	}
}

function funUserName()
{
	if(document.myForm.chk1!=null)
	{
		var len = document.myForm.chk1.length;
		var userName = ""
		if(isNaN(len))
		{
			if(document.myForm.chk1.checked)
			{
				userName = myUserName.innerText;
				document.myForm.userName.value = userName;
			}
		}
		else
		{
			for(var i=0;i<len;i++)		
			{
				if(document.myForm.chk1[i].checked)
				{
					userName = myUserName[i].innerText;
					document.myForm.userName.value = userName;
				}				
			}
			
		}
	}	
}

function funCheckBoxSingleResetPassword(area)
{
if(document.myForm.WebSysKey.selectedIndex != 0)
{
	var len=document.myForm.chk1.length;
	count=0;
	if(document.myForm.chk1.checked)
	{
	    //document.myForm.BusinessUser.value=document.myForm.chk1.value;
	    var chkKey 	= document.myForm.chk1.value
	    var chkKeyVal 	= chkKey.split("/");
	    //alert(chkKey+"------"+chkKeyVal);						
	    document.myForm.BusinessUser.value=chkKeyVal[0];
	    document.myForm.BPsyskey.value=chkKeyVal[1];
	    
	    funUserName();
	    count++;
	}
	for(i=0;i<len;i++)
	{
	   if(document.myForm.chk1[i].checked)
	   {
	       //document.myForm.BusinessUser.value=document.myForm.chk1[i].value;
	       var chkKey 	= document.myForm.chk1[i].value
	       var chkKeyVal 	= chkKey.split("/");
	       //alert(chkKey+"------"+chkKeyVal);						
	       document.myForm.BusinessUser.value=chkKeyVal[0];
	       document.myForm.BPsyskey.value=chkKeyVal[1];
	       
	       funUserName();
	       count++;
	   }
	}
	if(count==0)
	{
	    alert("Please Select the User to Reset Password")
	}

	else
	{
	     document.myForm.action="ezResetPasswordBySysKey.jsp"
	     document.myForm.submit();
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
				document.myForm.action="ezListAllUsersBySysKey.jsp";
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
	searchstring=showModalDialog('ezSearchDialog.jsp','','center:yes;dialogWidth:25;dialogHeight:16;status:no;minimize:yes')
	document.myForm.searchcriteria.value=searchstring;
	if(searchstring!=null)
	{
		if(searchstring.length!=0)
		{
			document.myForm.action="ezListAllUsersBySysKey.jsp?from=Search";
			document.myForm.submit();

		}
	}
}
