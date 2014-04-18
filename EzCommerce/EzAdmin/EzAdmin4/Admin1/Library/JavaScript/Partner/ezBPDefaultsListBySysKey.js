
//var tabHeadWidth=80
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


function placeFocus() {

	if(document.myForm.DefaultsValue != null)
	{
		if(document.myForm.DefaultsValue.length==null)
			document.myForm.DefaultsValue.focus()
		else
			document.myForm.DefaultsValue[0].focus()
			
	}	
/*
	if (document.forms.length > 0) {
	var field = document.forms[0];
		for (i = 0; i < field.length; i++) {
			if (field.elements[i].name == "DefaultsValue_0") {
		 	document.forms[0].elements[i].focus();
			break;
	 		}
	 	}
 	}
 */	
}


function myalert()
{
	myhost = window.location.host;
        myurl = document.URL;
        index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
        mUrl2 = "BusPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function soldtochange()
{
	myhost = window.location.host;
        myurl = document.URL;
        index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
        mUrl2 = "BusPartner=" + document.myForm.BusPartner.value+"&";
	mUrl3 = "SoldTo=" + document.myForm.SoldTo.value;
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	location.href= mUrl;
}

function syskeychange()
{
	myhost = window.location.host;
        myurl = document.URL;
        index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
        mUrl2 = "BusPartner=" + document.myForm.BusPartner.value+"&";
	mUrl3 = "SoldTo=" + document.myForm.SoldTo.value + "&";
	mUrl4 = "SysKey=" + document.myForm.SysKey.value;
	mUrl =  mUrl1 + mUrl2 + mUrl3 + mUrl4;
	location.href= mUrl;
}

