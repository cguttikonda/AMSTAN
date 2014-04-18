function selectAll()
	{
	var chkLen=document.myForm.chk1.length
	selected=!selected
	if(isNaN(chkLen))
		{
			document.myForm.chk1.checked=selected
		}
	else
		{
		for(i=0;i<chkLen;i++)
			document.myForm.chk1[i].checked=selected
		}
	}


 function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
// 	var OuterdivId1=document.getElementById("OuterBox1Div")
//	var ScrollBoxId1=document.getElementById("ScrollBoxDiv")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}

}
function funSelAll()
{
	for(var i=0;i<document.myForm.checks.value;i++)
	{
		s="document.myForm.RoleNr"+i;
		eval(s).checked=true;
	}
}
