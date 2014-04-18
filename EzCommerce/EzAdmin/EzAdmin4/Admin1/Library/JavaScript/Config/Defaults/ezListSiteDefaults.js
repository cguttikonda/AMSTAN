
//var tabHeadWidth=96
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
function funAdd()
{
	document.myForm.action="ezAddSiteDefaults.jsp";
	document.myForm.submit();
}

function funEdit()
{
	document.myForm.action="ezModifySiteDefaults.jsp";
	document.myForm.submit();
}
