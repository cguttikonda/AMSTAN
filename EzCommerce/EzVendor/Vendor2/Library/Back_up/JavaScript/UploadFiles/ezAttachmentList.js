function save()
{
	var attachString = "";
	var attachSelLength = document.myForm.attachs.length;
	for(var i=0;i<attachSelLength;i++)
	{
		if(document.myForm.attachs.options[i].selected==false)
		{
			if(i == 0)
				attachString=document.myForm.attachs.options[i].value;
			else
				attachString += ","+document.myForm.attachs.options[i].value;
		}
	}	
	
	window.returnValue=attachString;
	window.close();
	
}
function funAttach()
{
	attach=window.open("../Rfq/ezAttachFile.jsp","AttachWindow","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=no,toolbar=no,menubar=no,status=no");
}
function funRemove()
{
	var attachments=new Array();
	var j=0;
	var count=0;
	if(document.myForm.attachs.length>0)
	{
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected==true)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please Select a File To Delete");
		}
	}
	else
	{
		alert("No Attachments To Remove");
	}
	for(var i=0;i<document.myForm.attachs.length;i++)
	{
		if(document.myForm.attachs.options[i].selected==false)
		{
			attachments[j]=document.myForm.attachs.options[i].value;
			j++;
		}
	}

	for(var i=document.myForm.attachs.length;i>=0;i--)
	{
		document.myForm.attachs.options[i]=null;
	}
	for(var i=0;i<attachments.length;i++)
	{
		document.myForm.attachflag.value="true"
		document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
	}
}		
function closeWindow()
{
	window.returnValue="";
	window.close();	
}
function checkAttachedFiles(attachString)
{
	if(attachString == null || attachString == "" || attachString == "undefined")
		return;
	if(attachString.indexOf(",") == -1)
	{
		document.myForm.attachs.options[0]=new Option(attachString,attachString);
	}
	else
	{
		var attachments = attachString.split(",");
		for(var i=0;i<attachments.length;i++)
		{
			document.myForm.attachflag.value="true"
			document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
		}
	}	
}
function checkVal()
{
	save()
}
