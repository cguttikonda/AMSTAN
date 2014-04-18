function setConnections(s) 
{
	var connFlag = document.myForm.changeConnectionFlag.value;
	if(connFlag=='T')
	{
		document.myForm.changeConnectionFlag.value='F';
		var parameters = 'ezCreateConnection.jsp?params='+s;
		//location.href=parameters;
		document.myForm.action=parameters
		document.myForm.submit()
	}
}
function funAdd()
{
	document.location.href = "../CParam/ezAddConnectParam.jsp"
}

function funUpdate()
{
	document.location.href = "../CParam/ezUpdateConnectParam.jsp"
}
function funDelete()
{
	document.location.href = "../CParam/ezDeleteConnectParam.jsp"
}
