var tc

function displayDate()
{
	for (i=1;i<total;i++)
	{ 
		obj = eval("document.forms[0].desiredDate["+i+"]");
		if(obj.value=="")
		{
			obj.value=document.generalForm.desiredDate.value
		}
	}
}
function fun1()
{
	
	if(newWindow.closed)
	{
		displayDate()
		clearInterval(tc)
	}

}
function fun2()
{
	tc=setInterval("fun1()",500)
}