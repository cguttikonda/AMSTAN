function chkSubmit()
{
	var myFlag=true
	var myFlag1=true
	
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();
	
	
	if (funTrim(document.myForm.toUser.value)=="")
	{
		alert("Please Enter To");
		document.myForm.toUser.focus();
		return false;
	}
					
	
	FieldNames[0]="toUser";
	CheckType[0]="MEMAILS";
	Messages[0]="Please enter Valid Email for To ";
	
	
	FieldNames[1]="ccUser";
	CheckType[1]="PEMAILS";
	Messages[1]="Please enter Valid Cc";
	
	FieldNames[2]="bccUser";
	CheckType[2]="PEMAILS";
	Messages[2]="Please enter Valid Bcc";
	
			
	return funCheckFormFields(document.myForm,FieldNames,CheckType,Messages);
	
}
function funReset()
{
	document.myForm.reset();
	
}



function cancelMsg() 
{
	document.forms[0].action = "../Inbox/ezListPersMsgs.jsp";
	document.returnValue = true;
}

function getAddressWindow()
{
	var url = "ezSelectUsers.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=400,height=400,left=150,top=100,resizable=false,scrollbars=yes,toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}




function getAttachWindow()
{
	var attachedFiles="";
	var val=document.myForm.attachs.value
	if(val != "")
	{
		var arr=val.split('\n')
		for(var i=0;i<arr.length;i++)
		{
			if(arr[i] != "")
			{
				if(attachedFiles == "")
					attachedFiles = arr[i]
				else
					attachedFiles += "&attachedFiles="+arr[i];
			}
		}

	}

	var url = "ezAttachment.jsp?attachedFiles="+attachedFiles;
	var hWnd = 	window.open(url,"UserWindow","width=600,height=325,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}


function doAttach()
{
	var s="";
	if(document.myForm.attachList.length > 0)
		s=s+document.myForm.attachList.options[0].value;
	for(var i=1;i<document.myForm.attachList.length;i++)
	{
		s = s +"\n"+document.myForm.attachList.options[i].value;
	}
	parent.opener.myForm.attachs.value=s;
	window.close();
}


function doAttachFile()
{

	var val=document.myForm.attachFile.value
	
	
	if(val.lastIndexOf('\\') > 0)
		val=val.substring(val.lastIndexOf('\\')+1,val.length)
	else if(val.lastIndexOf('/') > 0)
		val=val.substring(val.lastIndexOf('/')+1,val.length)
	

	if(document.myForm.attachFile.value!="")
	{
		var attachedFiles="";
		var flag=false
		if(document.myForm.attachList.length > 0)
		{
			attachedFiles=document.myForm.attachList.options[0].value
			if(val == document.myForm.attachList.options[0].value)
				flag=true
		}
		for(var i=1;i<document.myForm.attachList.length;i++)
		{
			attachedFiles += "&attachList="+document.myForm.attachList.options[i].value
			if(val == document.myForm.attachList.options[i].value)
				flag=true
		}

		if(flag)
		{
			alert("File with this name is already attached")
		}
		else
		{
			document.myForm.action="ezUploadFiles.jsp?attachList="+attachedFiles;
			document.myForm.submit();
		}	
	}
	else
	{
		alert("Please select the file to attach");
	}
}

function doRemove()
{
	var count=0;
	if(document.myForm.attachList.length==0)
	{
		alert("Currently no attachments in your list");
	}
	else
	{
		for(var i=0;i<document.myForm.attachList.length;i++)
		{
			if(document.myForm.attachList.options[i].selected)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please select the files to remove");
		}
		else
		{
			var attachedFiles="";
			var toBeDelFiles="";
			if(document.myForm.attachList.length > 0)
			{
				attachedFiles=document.myForm.attachList.options[0].value
				if(document.myForm.attachList.options[0].selected)
					toBeDelFiles=document.myForm.attachList.options[0].value
			}
			for(var i=1;i<document.myForm.attachList.length;i++)
			{
				attachedFiles += "&allAttachedList="+document.myForm.attachList.options[i].value
				if(document.myForm.attachList.options[i].selected)
				{
					if(toBeDelFiles == "")
						toBeDelFiles = document.myForm.attachList.options[i].value
					else
						toBeDelFiles += "&toBeDelFiles="+document.myForm.attachList.options[i].value
				}
			}

			document.myForm.action="ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles;
			document.myForm.submit();
		}
	}
}

function doCancel()
{
   document.temp1.action="ezAttachment.jsp?operation=cancel";
   document.temp1.submit();
}
