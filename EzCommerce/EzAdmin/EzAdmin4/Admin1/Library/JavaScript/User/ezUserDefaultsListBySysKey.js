 
//var tabHeadWidth=79
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

function funsubmit()
{
	document.myForm.BusUser.options[0].selected=true;
	document.myForm.action="ezUserDefaultsListBySysKey.jsp";
	document.myForm.submit();
}


function funsubmit1(area)
{
	if(document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel" && document.myForm.BusUser.options[document.myForm.BusUser.selectedIndex].value=="sel")
	{
		alert("Please Select "+area +" and User");
		return;
	}
	

	if(document.myForm.BusUser.options[document.myForm.BusUser.selectedIndex].value=="sel")
	{
		alert("Please select User");
	}
	else
	{
		document.myForm.action="ezUserDefaultsListBySysKey.jsp";
		document.myForm.submit();
	}
}

function myalert1()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";

	mUrl2 = "BusUser=" + document.myForm.BusUser.value;

	mUrl =  mUrl1 + mUrl2 ;

	location.href= mUrl;
}

function placeFocus() {
	if (document.forms.length > 0) {
	var field = document.forms[0];
		for (i = 0; i < field.length; i++) {
			if (field.elements[i].name == "DefaultsValue_0") {
		 	document.forms[0].elements[i].focus();
			break;
	 		}
	 	}
 	}
}


function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "SystemKey=" + document.myForm.SystemKey.value + "&";
	mUrl3 = "BusUser=" + document.myForm.BusUser.value;

	mUrl =  mUrl1 + mUrl2 + mUrl3;

	location.href= mUrl;
}

function funSelect()
{
	if(document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please Select the User");
		return false;
	}
	else
	{
		return true;		
	}

}
