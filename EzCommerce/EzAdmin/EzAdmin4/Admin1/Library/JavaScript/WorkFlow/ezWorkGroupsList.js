 function funSubmit()
 {
 	//document.myForm.searchcriteria.value="A*";
 	document.myForm.action = "ezWorkGroupsList.jsp"
 	document.myForm.submit();
 }
function funWGUsers()
{
	var wgUser="";
	var len = document.myForm.chk1.length;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			wgUser = document.myForm.chk1.value;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				wgUser = document.myForm.chk1[i].value;
			}
		}
	}
	if(wgUser=="")
	{
		alert("Please Select a Work Group to view Users.")
	}
	else
	{
		var group = wgUser.split(",")
		document.myForm.action = "ezWorkGroupUsersList.jsp?myFlag=N&groups="+group[0]
		document.myForm.submit();
	}
}

 function ezAlphabet(alphabet)
 {
 	var role=document.myForm.role[document.myForm.role.selectedIndex].value
 	searchstring=alphabet+"*";
 	if(searchstring=="All*")
 		document.myForm.searchcriteria.value="";
 	else
 		document.myForm.searchcriteria.value=searchstring;
 	if(searchstring!=null)
 	{
 		if(searchstring.length!=0)
 		{
			if(document.myForm.role.selectedIndex != 0)
			{
				document.myForm.action="ezWorkGroupsList.jsp";
 				document.myForm.submit();
			}
			else
			{
				alert("Please Select Role.")
			}
 		}
 	}
}
