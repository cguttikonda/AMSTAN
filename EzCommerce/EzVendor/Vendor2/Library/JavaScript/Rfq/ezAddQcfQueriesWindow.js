function closeWindow()
{
	if(!checkRoleAuthorizations("SEND_QUERY"))
	{
		alert("You are not authorized to send query");
		return;
	}	
	
	if(document.myForm.qcfComments.value=="")
	{
		alert("Please Enter Query String");
		document.myForm.qcfComments.focus();
		return;
	}
	else
	if(document.myForm.qcfComments.value.length>1000)
	{
		alert("Query String Should Not Be More Than 1000 Characters");
		document.myForm.qcfComments.focus();
		return;
	}
	
	alert("Before Calling Save Query");
	var dialogvalue=window.showModalDialog("ezQueryToUser.jsp",window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;resizable=no")
	alert("After Calling Save Query");
	if(dialogvalue != null && dialogvalue != "")
	{
		window.opener = window.dialogArguments;
		document.myForm.QcfNumber.value		=	window.opener.document.myForm.QcfNumber.value;
		document.myForm.qcsCommentNo.value	=	window.opener.document.myForm.qcsCommentNo.value;
		document.myForm.Type.value		=	window.opener.document.myForm.commentType.value;
		document.myForm.Initiator.value		=	dialogvalue;
		document.getElementById("ButtonsDiv").style.visibility="hidden"
		document.getElementById("msgDiv").style.visibility="visible"
		document.myForm.action="ezAddSaveQcfQuery.jsp";
		document.myForm.submit();
	}	
}
