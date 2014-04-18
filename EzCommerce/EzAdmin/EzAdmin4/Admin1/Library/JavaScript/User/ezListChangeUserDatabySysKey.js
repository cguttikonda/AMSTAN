// var tabHeadWidth=80
 function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
// 	var OuterdivId1=document.getElementById("OuterBox1Div")
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
		document.myForm.action="ezListChangeUserDatabySysKey.jsp";
		document.myForm.submit();
	}
}