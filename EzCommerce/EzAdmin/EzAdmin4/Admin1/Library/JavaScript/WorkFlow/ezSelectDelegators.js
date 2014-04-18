function fillOptions()
{
	if(document.myForm.Role.selectedIndex == -1 || document.myForm.Role.selectedIndex == 0)
		alert("Please select Role");
	else
	document.myForm.submit()
}
function saveSelected()
{
	var dstUsers = "";
	var counter = 0
	for(i=0;i<document.myForm.delDstLevel.options.length;i++)
	{
		if(document.myForm.delDstLevel.options[i].selected)
		{
			if(counter == 0)
				dstUsers = document.myForm.delDstLevel.options[i].value;
			else
				dstUsers += "¥"+document.myForm.delDstLevel.options[i].value;
			counter++;	
		}	
		
	}	
	window.opener 	= 	window.dialogArguments
	var hiddenDelObj	=	opener.document.myForm.delegatLevel;
	hiddenDelObj.value	=	document.myForm.Level.value
	
	var hiddenDelSrcObj	=	opener.document.myForm.srcHiddenDel;
	
	if(document.myForm.Level.value == 'U')
		hiddenDelSrcObj.value	=	document.myForm.delSrcUser.value
	else
		hiddenDelSrcObj.value	=	document.myForm.delSrcLevel.value
	
	var hiddenDelDstObj	=	opener.document.myForm.dstHiddenDel;
	hiddenDelDstObj.value	=	dstUsers;	
	
	close()
}

function fillGroupUsers()
{
	if(document.myForm.Level.value == 'U')
	{
		document.myForm.submit()
	}
}