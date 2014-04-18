	//var tabHeadWidth=80
function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	//var ScrollBoxId1=document.getElementById("ScrollBoxDiv");
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
	
	document.myForm.action="ezUserOnlyDefaultsListBySysKey.jsp";
	document.myForm.submit();
}



function funsubmit1(area)
{

	if(document.myForm.WebSysKey.selectedIndex==0 && document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please Select "+area +" and User");
		return;
	}
	if(document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please select User");
	}
	else
	{
		document.myForm.action="ezUserOnlyDefaultsListBySysKey.jsp";
		document.myForm.submit();
	}
}

function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessUser=" + document.myForm.BusUser.value;
		mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function funSelect()
{
	if(document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please Select User");
		return false;
	}
	else
	{
		return true;
	}
}