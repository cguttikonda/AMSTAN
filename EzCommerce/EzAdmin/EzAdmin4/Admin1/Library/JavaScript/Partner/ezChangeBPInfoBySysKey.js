
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
	document.ChangeBP.BusPartner.options[0].selected=true;
	document.ChangeBP.action="ezChangeBPInfoBySysKey.jsp";
	document.ChangeBP.submit();
}


function funsubmit1()
{
	if(document.ChangeBP.BusPartner.options[document.ChangeBP.BusPartner.selectedIndex].value=="sel" && document.ChangeBP.WebSysKey.options[document.ChangeBP.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select Area and BussinessPartner");
		return;
	}

	if(document.ChangeBP.BusPartner.options[document.ChangeBP.BusPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.ChangeBP.action="ezChangeBPInfoBySysKey.jsp";
		document.ChangeBP.submit();
	}
}


function disNumUsers()
{
	if ( document.forms[0].UnlimitedUsers[0].checked || !document.forms[0].UnlimitedUsers[1].checked)
	{
		document.forms[0].NumUsers.disabled = true;
	}

	if ( document.forms[0].UnlimitedUsers[1].checked || !document.forms[0].UnlimitedUsers[0].checked)
	{
		document.forms[0].NumUsers.disabled = false;
	}
}




function checkAll()
{
	var form = document.forms[0]
	for (i = 0; i < form.elements.length; i++) {
		var name = form.elements[i].name;
		if(name.charAt(0) == "*") continue;
			if (form.elements[i].type == "text" &&
      		form.elements[i].value == ""){
			if (form.elements[i].name != "NumUsers"){
			   	alert("Please fill out all the fields.")
		      	form.elements[i].focus();
				document.returnValue = false;
				return;
			}else{
                        if(!document.forms[0].UnlimitedUsers[0].checked) {
					alert("Please fill out Number Of Users.")
					form.NumUsers.focus();
					document.returnValue = false;
                                        return;
			}//End if
                  }
		}else{
				document.returnValue = true;

		}//End if
	}//End for

}

function myalert(){

	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessPartner=" + document.ChangeBP.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;

}
