
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
function setChecked(chkVal)
{
	var len=document.myForm.CheckBox.length;
	if(isNaN(len))
	{
		document.myForm.CheckBox.checked=chkVal;
	}
	else
	{
		for ( i=0; i<len; i++)
		{
			document.myForm.CheckBox[i].checked = chkVal;
		}
	}
}

