function funOpenFile()
{
	var dbClickOnFlNm = document.generalForm.attachs.value
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../UploadFiles/ezViewFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");
	}	
}
function funAttach()
{
	attach=window.open("../UploadFiles/ezAttachFile.jsp","UserWindow1","width=450,height=350,left=350,top=120,resizable=yes,scrollbars=no,toolbar=no,menubar=no,status=no");
}
function funRemove()
{
	var attachments=new Array();
	var j=0;
	var count=0;
	if(document.generalForm.attachs.length>0)
	{
		for(var i=0;i<document.generalForm.attachs.length;i++)
		{
			if(document.generalForm.attachs.options[i].selected==true)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please Select a File To Remove");
		}
	}
	else
	{
		alert("No Attachments To Remove");
	}
	for(var i=0;i<document.generalForm.attachs.length;i++)
	{
		if(document.generalForm.attachs.options[i].selected==false)
		{
			attachments[j]=document.generalForm.attachs.options[i].value;
			j++;
		}
	}

	for(var i=document.generalForm.attachs.length;i>=0;i--)
	{
		document.generalForm.attachs.options[i]=null;
	}
	for(var i=0;i<attachments.length;i++)
	{
		document.generalForm.attachflag.value="true"
		document.generalForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
	}
}