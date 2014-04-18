<%
	String actType = request.getParameter("actType");
	String attachedFiles = (String)session.getValue("ATTACHEDFILES");//request.getParameter("attacheddFiles");
%>
<html>
<head>

<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
<script src="../../Library/JavaScript/Misc/Trim.js"></script>
<title>Attachments</title>
<script>
	function doRemove()
	{
		var count=0;
		if(document.myForms.attachs.length==0)
		{
			alert("No Attachments To Remove");
		}
		else
		{
			for(var i=0;i<document.myForms.attachs.length;i++)
			{
				if(document.myForms.attachs.options[i].selected)
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
				if(document.myForms.attachs.length > 0)
				{
					attachedFiles=document.myForms.attachs.options[0].value
					if(document.myForms.attachs.options[0].selected)
						toBeDelFiles=document.myForms.attachs.options[0].value
				}
				for(var i=1;i<document.myForms.attachs.length;i++)
				{
					attachedFiles += "&allAttachedList="+document.myForms.attachs.options[i].value
					if(document.myForms.attachs.options[i].selected)
					{
						if(toBeDelFiles == "")
							toBeDelFiles = document.myForms.attachs.options[i].value
						else
							toBeDelFiles += "&toBeDelFiles="+document.myForms.attachs.options[i].value
					}
				}

				document.myForms.action="ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles+"&flag=N";
				document.myForms.submit();
			}
		}
	}
	function funRemove()
	{
		var attachments=new Array();
		var j=0;
		var count=0;
		if(document.myForms.attachs.length>0)
		{
			for(var i=0;i<document.myForms.attachs.length;i++)
			{
				if(document.myForms.attachs.options[i].selected==true)
				{
					count++;
				}
			}
			if(count==0)
			{
				alert("Please Select a File To Remove");
				//return false;
			}
		}
		else
		{
			alert("No Attachments To Remove");
			//return false;
		}
		for(var i=0;i<document.myForms.attachs.length;i++)
		{
			if(document.myForms.attachs.options[i].selected==false)
			{
				attachments[j]=document.myForms.attachs.options[i].value;
				j++;
			}
		}

		for(var i=document.myForms.attachs.length;i>=0;i--)
		{
			document.myForms.attachs.options[i]=null;
		}
		for(var i=0;i<attachments.length;i++)
		{
			//document.myForms.attachflag.value="true"
			document.myForms.attachs.options[i]=new Option(attachments[i],attachments[i]);
		}
	}

	var parentObj="";
	var docObj="";
	var filePaths = "";

	if(opener.document.generalForm.filePaths!=null)
		filePaths =opener.document.generalForm.filePaths.value;

	if(!document.all)
	{
		parentObj = opener.document.generalForm
		docObj = opener.document
	}
	else
	{
		parentObj = parent.opener.generalForm
		docObj = parent.opener.document
	}

	function openBrowse(i)
	{
		eval("document.myForms.f"+i).click()
	}
	function setFname(j)
	{
		var path = eval('document.myForms.f'+j).value
		var x = path.lastIndexOf('\\')
		var fileName=path.substring(x+1,path.length);
		//eval('document.myForms.n'+j).value=fileName
	}

	function funClose()
	{
		var path = document.myForms.f1.value
		if(funTrim(path)=="")
		{
			alert("Please browse a file");
			return false;
		}
		else
		{
			var dotPos 	= path.lastIndexOf('.');
			var fileExt	= path.substring(dotPos+1,path.length);
			/*			
			if(!(fileExt == "ppt" || fileExt == "htm" || fileExt == "zip" || fileExt == "html" || fileExt == "tif" || fileExt == "pdf" || fileExt == "doc" || fileExt == "xls" || fileExt == "docx" || fileExt == "xlsx" || fileExt == "PPT" || fileExt == "HTM" || fileExt == "ZIP" || fileExt == "HTML" || fileExt == "TIF" || fileExt == "PDF" || fileExt == "DOC" || fileExt == "XLS" || fileExt == "DOCX" || fileExt == "XLSX"))
			{
				alert("Please attach only files of below given file types \n --- Excel , Word , PPT , PDF Documents \n --- Html, Tif and Zip Files");
				return;
			}

			var x 		= path.lastIndexOf('\\')
			var fileName	= path.substring(x+1,path.length);
			var len		= docObj.generalForm.attachs.length;
			var winFileLen	= document.myForms.attachs.length;
			for(var i=0;i<len;i++)
			{
				if(parentObj.attachs.options[i].value==fileName)
				{
					alert("File With This Name is Already Attached")
					return;
				}
			}
			
			for(var j=0;j<winFileLen;j++)
			{
				if(document.myForms.attachs.options[j].value==fileName)
				{
					alert("File With This Name is Already Attached")
					return;
				}
			}
			
			//The following is for getting the file path from where a file is attached from the local system.These are used in the parent window to show the content in the attached file when clicked on the file name.
			if(filePaths=="")
				filePaths = path+"$$"+fileName;
			else 
				filePaths = filePaths+"##"+path+"$$"+fileName;

			if(opener.document.generalForm.filePaths!=null)          
				opener.document.generalForm.filePaths.value = filePaths;
			*/
			
			document.getElementById("attachment").style.visibility="hidden";
			document.getElementById("selBox").style.visibility="hidden";
			//document.getElementById("buttonsDiv").style.visibility="hidden";
			document.myForms.filepath.value=path
			setTimeout("funWait()","200");
			//Upto now we had the facility of attaching only one file but this is enable the user to attach more than one file from the same window.
			//attchdFiles hidden field value is being gotten in the ezUploadFiles.jsp for sending attached files list to this page again to show them.
			var len=document.myForms.attachs.length;
			var filesStr = "";
			if(len!=null)
			{
				if(!isNaN(len))
				{
					for(var i=0;i<len;i++)
					{
						
						if(i==0)
							filesStr = document.myForms.attachs.options[0].value;
						else
							filesStr = filesStr+"$$"+document.myForms.attachs.options[i].value;
						
					}
				}
			}	
			
			document.myForms.attchdFiles.value = filesStr;
			document.myForms.action="ezUploadFiles.jsp";
			document.myForms.submit();
		}
	}

	function funWait()
	{
		document.getElementById("image").style.visibility = "visible";
		document.body.style.cursor='wait'
	}
	
	
	//The following function is used for getting parent window object.
	var parentObj="";
	var docObj="";
	if(!document.all)
	{
		parentObj = opener.document.generalForm
		docObj = opener.document
	}
	else
	{
		parentObj = parent.opener.generalForm
		docObj = parent.opener.document
	}
	
	//When clicked on Ok button then following function is used for sending the attached files list to the parent page i.e select box in the parent window.
	function sendToselBox()
	{
		var len=docObj.generalForm.attachs.length

		var len=document.myForms.attachs.length;
		if(len!=null)
		{
			if(!isNaN(len))
			{
				for(var i=0;i<len;i++)
				{
					filesStr = document.myForms.attachs.options[i].value;
					if(window.navigator.appName =="Microsoft Internet Explorer")
					{
						var newOpt = docObj.createElement("OPTION")
						newOpt.value=filesStr;
						newOpt.text=filesStr;
						docObj.generalForm.attachs.add(newOpt)
					}
					else
					{
						parentObj.attachs.options[len]=new Option(filesStr,filesStr);
					}	

				}
			}
		}	
		window.close();
	}
	function closeAttach()
	{
		parent.$.fancybox.close();  
	}
</script>
</head>
<body scroll=no>
<Form name="myForms" ENCTYPE="multipart/form-data" method="POST" >
<div class="page">
<input type=hidden name=filepath>
<input type=hidden name=attchdFiles>
<input type=hidden name=actType value="<%=actType%>">
<div id="attachment">
<ul class="form-list">
	<li><h2>1. Choose a file to attach.</h2></li>
	<li><input type=file   value="" name="f1" onPropertyChange="setFname(1)" style="width:100%"><Br><Br></li>
	<li><h2>2. Add the file to the list.</h2></li>
	<li>
		<input type="button" name="done" value="Attach" onClick="funClose()" style="width:20%">
		<input type="button" name="remove" value="Remove" onClick="doRemove()" style="width:20%">
	</li>
</ul>
</div>
<div id="selBox">
<ul class="form-list">
	<li><h3>Current file attachments.</h3></li>
	<li><select name="attachs" style="width:100%; height:155px;" size="4" scroll=no></li>
</ul>
<ul class="form-list">
	<li><h2>3. <input type="button" name="Go Back To Order" value="Done" onClick="closeAttach()" style="width:30%"></h2></li>
</ul>
</div>
<!--<Div id="buttonsDiv" style='Position:Absolute;WIDTH:100%;Top:90%'>
	<button type="button" onClick="sendToselBox()" class="button btn-update"><span>Ok</span></button>
</Div>-->
<Div id="image" style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:30%;height:30%;Top:15%'>
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li>&nbsp;</li>
	</ul>
</Div>

<Script>
<%
	//This code is used to get the attached files after every file  attachment.
	java.util.StringTokenizer  filesStk = null;
	String fileName = "";
	int i=0;
	if(attachedFiles!=null)
	{
		filesStk	= new java.util.StringTokenizer(attachedFiles,"$$");
		while(filesStk.hasMoreElements())
		{
			fileName = filesStk.nextToken();
%>
				document.myForms.attachs.options[<%=i%>]=new Option('<%=fileName%>','<%=fileName%>');
<%
			i++;
		}
%>
		document.myForms.remove.disabled = false;
<%
	}
%>
</Script>
</div>
</form>
</body>
</html>
