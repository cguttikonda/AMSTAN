function fillOptions()
{
	document.myForm.submit()
}
function checkSelected(valueObj)
{
	if(valueObj == null || valueObj == "" || valueObj == "-")
		return false;
	
	return true;
}
function saveSelected()
{
	

	window.opener 	= 	window.dialogArguments
	
	var hiddenTempObj	=	eval("opener.document.myForm.template");
	if(!checkSelected(document.myForm.template.value))
	{
		alert("Please select Template");
		return;
	}
	else
		hiddenTempObj.value	=	document.myForm.template.value
	
	var hiddenSrcObj	=	eval("opener.document.myForm.srcLevel");
	
	if(!checkSelected(document.myForm.srcLevel.value))
	{
		alert("Please select Source Step");
		return;
	}
	else
		hiddenSrcObj.value	=	document.myForm.srcLevel.value
	
	var hiddenDstObj	=	eval("opener.document.myForm.dstLevel");
	if(!checkSelected(document.myForm.dstLevel.value))
	{
		alert("Please select Destination Step");
		return;
	}
	else
		hiddenDstObj.value	=	document.myForm.dstLevel.value;
	
	var hiddenDirectionObj	=	eval("opener.document.myForm.direction");
	if(!checkSelected(document.myForm.direction.value))
	{
		alert("Please select Direction");
		return;
	}
	else
		hiddenDirectionObj.value=	document.myForm.direction.value;
	close()
}

function fillTemplateSteps()
{
	document.myForm.submit()
}


function fillDefaults()
{
	window.opener 	= 	window.dialogArguments
	
	var hiddenTempObj	=	eval("opener.document.myForm.template");
	if(hiddenTempObj != null && (hiddenTempObj.value != "" && hiddenTempObj.value != null))
		document.myForm.template.value = hiddenTempObj.value
		
		
	var hiddenSrcObj	=	eval("opener.document.myForm.srcLevel");
	if(hiddenSrcObj != null && (hiddenSrcObj.value != "" && hiddenSrcObj.value != null))
		document.myForm.srcLevel.value = hiddenSrcObj.value
	
	var hiddenDstObj	=	eval("opener.document.myForm.dstLevel");
	if(hiddenDstObj != null && (hiddenDstObj.value != "" && hiddenDstObj.value != null))
		document.myForm.dstLevel.value = hiddenDstObj.value
}