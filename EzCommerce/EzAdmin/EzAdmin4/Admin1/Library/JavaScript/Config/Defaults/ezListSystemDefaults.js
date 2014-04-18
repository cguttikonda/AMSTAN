
function init()
 	{
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	if(InnerdivId1!=null)
 		{
		myInit(2)
		if(getposition())
			{
			ScrollBox.show()
			}
		}		
	}
	
function focus()
{
   document.myForm.SysKeyDesc.focus();
}

function myalert()
	{
	if(document.forms[0].SystemKey.selectedIndex==0)
		{
		alert("Please Select Business Area.");
		document.forms[0].SystemKey.focus();				
		document.returnValue=false;
		}
	else
		{
		myurl = document.URL;
		index = myurl.indexOf(".jsp");
 		newurl = myurl.substring(0, index);
		mUrl1 =  newurl + ".jsp?";
		mUrl2 = "SystemKey=" + document.myForm.SystemKey.value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
		}
	}

function funAdd()
{
	document.myForm.action="ezAddSystemDefaults.jsp";
	document.myForm.submit();
}

function funEdit()
{
	document.myForm.action="ezModifySystemDefaults.jsp";
	document.myForm.submit();
}
