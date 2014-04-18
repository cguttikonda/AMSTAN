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
		document.myForm.action="ezGetPasswordForSelectedUser.jsp";
		document.myForm.submit();
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
				document.myForm.action="ezGetPasswordForSelectedUser.jsp";
				document.myForm.submit();
			}
			else
			{
				alert("Please Select "+areaLabel);
			}
		}
	}
}

function funOpenPWWin(userID)
{
	var retValue = window.showModalDialog("ezDisplayPassword.jsp?usrId="+userID,window.self,"center=yes;dialogHeight=25;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes");
}	


