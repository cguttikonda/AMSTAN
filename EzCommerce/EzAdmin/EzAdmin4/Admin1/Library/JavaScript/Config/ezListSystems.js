

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


function funAdd()
{
	document.myForm.action="ezAddSystemDesc.jsp";
	document.myForm.submit();
}

function funEdit()
{
	document.myForm.action="ezUpdateSystems.jsp";
	document.myForm.submit();
}
