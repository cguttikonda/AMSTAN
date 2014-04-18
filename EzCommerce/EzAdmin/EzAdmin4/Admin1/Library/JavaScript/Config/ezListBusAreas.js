


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

function funAdd(area)
{
	document.myForm.action="ezAddBusAreaDesc.jsp?Area="+area;
	document.myForm.submit();
}

function funEdit(area)
{
	document.myForm.action="ezUpdateBusAreas.jsp?Area="+area;
	document.myForm.submit();
}
