function getAttachWindow()
{
	attachedFiles="";
	fileData=document.myForm.attachx.value;
	if(fileData != "")
	{
		fileNames = fileData.split(",")
		for(i=0;i<fileNames.length;i++)
		{
			if(fileNames[i] != "")
			{
				if(attachedFiles == "")
					attachedFiles = fileNames[i];
				else
					attachedFiles += "&attachedFiles=" +fileNames[i];
			}
		}
	}
	//var url = "../Components/ezAttachment.jsp?attachedFiles="+attachedFiles;
	var url = "../EzcSFA/ezAttachment.jsp?attachedFiles="+attachedFiles;
	window.open(url,"AttachmentWindow","toolbar=no,status=no,scrollbars=no,location=no,menubar=no,resizable=no,directories=no,width=450,height=300,top=10,left=10");
}


function doAttach()
{
	var docBody = "window.opener.document";
	var docPath = "window.opener.document.myForm";
	var retText=eval(docPath+".attachs");
	var retData=eval(docPath+".attachx");
	var s="";atachd="";
	if(document.myForm.attachList.length > 0)
		s = s+document.myForm.attachList.options[0].value
	for(var i=1;i<document.myForm.attachList.length;i++)
		s = s+","+document.myForm.attachList.options[i].value;
	if(s.charAt(s.length-1) == ",")
			s = s.substring(0,s.length-1)
	retText.value="Y";
 	retData.value=s;
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
			alert("File With This Name Is Already Attached")
		}
		else
		{
			document.myForm.action="ezUploadFiles.jsp?attachList="+attachedFiles;
			document.myForm.submit();
		}
	}
	else
	{
		alert("Please Select The File To Attach");
	}
}

function doRemove()
{
	var count=0;
	if(document.myForm.attachList.length==0)
	{
		alert("Currently No Attachments In Your List");
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
			alert("Please Select The Files To Remove");
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

			document.myForm.action="../Inbox/ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles;
			document.myForm.submit();
		}
	}
}

function doCancel()
{
   document.temp1.action="ezAttachment.jsp?operation=cancel";
   document.temp1.submit();
}

function chkSubmit()
{
	if(document.myForm.releasedOn.value=="" ||document.myForm.releasedOn.value==null)
	{
		alert("Please Select Date");
		return;
	}
	else
	{
		var todaysDate = new Date();
		var releasedDate = (document.myForm.releasedOn.value).split("/")
		var checkDate = new Date(releasedDate[2],(parseInt(releasedDate[0])-1),releasedDate[1])
		if(checkDate > todaysDate)
		{
			alert("Released Date should be equal to or less than Todays Date")
			return;
		}
	}
	
	if(document.myForm.attachx.value=="" || document.myForm.attachx.value==null)
	{
		alert("Please attach file");
		return;
	}
	else
	{
		var fileName = document.myForm.attachx.value
		for(i=0;i<fileName.length;i++)
		{
			if(fileName.charAt(i) == ' ')
			{
				alert("Please Dont Enter Any Spaces In Attached File Name");
				return;
			}
		}
	}
	

	document.myForm.action="ezAddSaveComponentVersionHistory.jsp"
	document.myForm.submit();

}
