<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAttachFile_Lables.jsp"%>
<%
	String attachedFiles =	request.getParameter("attacheddFiles");//(String)session.getValue("ATTACHEDFILES");
%>
<html>
<head>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<title>Attachments --Powered By EzCommerce Inc</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>


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
			alert("<%=browseFile_L%>");
			return false;
		}
		else
		{
			var dotPos 	= path.lastIndexOf('.');
			var fileExt	= path.substring(dotPos+1,path.length);
			
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
			
			document.getElementById("attachment").style.visibility="hidden";
			document.getElementById("selBox").style.visibility="hidden";
			document.getElementById("buttonsDiv").style.visibility="hidden";
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
		document.getElementById("image").style.visibility="visible";
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

	

</script>
</head>
<body scroll=no>
<%
	String index=request.getParameter("index");
	session.putValue("INDEX",index);
%>
<Form name="myForms" ENCTYPE="multipart/form-data" method="POST" >
<input type=hidden name=filepath>
<input type=hidden name=attchdFiles>
<Table border=0 width="100%" align="center" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
  		<Tr>
  			<Th align="center">
  				<Font style="color:#000000" size=3>File Attachment</Font>	
  			</Th>
  		</Tr>	
</Table>  		
<Div id="attachment" style='Position:Absolute;visibility:visible;width:100%;height:70%;Top:20%'>
	<TABLE border=0 width="100%" align="left" borderColorDark=#ffffff borderColorLight=#000000>
  		<Tr>
  			<Th class="blankcell" align="left">
  				<Font style="color:#ffffff" size=3 face="Times">
  					Choose a file to attach.
  					<!--After File is selected, Click on Add File.-->
  				</Font>
  			</Th>
  		</Tr>
 		<Tr>
 			<td class="blankcell">
 				<input type=file   value="" name="f1" onPropertyChange="setFname(1)" style="width:100%"><Br><Br>
 			</td>
 		</Tr>
 		<Tr>
			<Th class="blankcell" align="left">
				<Font style="color:#ffffff" size=3 face="Times">
					Add the file to the list.
					<!--After File is selected, Click on Add File.-->
				</Font>
			</Th>
		</Tr>
		<Tr>
			<td class="blankcell"  align="right">
				<input type="button" name="done" value="Attach" onClick="funClose()" style="width:20%">
			</td>
 		</Tr>
 		
 		
 		
 		
 		
 		
 		</Table>
 	</Div>	
	 <Div  id="selBox" style='Position:Absolute;visibility:visible;width:100%;height:70%;Top:55%'>

 		<TABLE border=0 width="100%" align="left" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
 		<Tr>
			<Th colspan=2 class="blankcell" align="left">
			<Font style="color:#ffffff" size=3 face="Times">
				<!--Click on Remove, If you want to remove an attached file.-->
				Current file attachments.
			</Font>	
			</Th>
 		</Tr>
 		<Tr>
 			<Td align="center" width=80%>
				<select name="attachs" style="width:100%" size=4>
				</select>
			</Td>
 			<Td align="right" width=20% class="blankcell">
				<!--<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File">
				<img alt="Delete Attachment"  src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand;width:30;height:25' border=none>
				<Font style="color:#FF6633" size=4 face="Times">Remove</Font>-->
					<input type="button" name="remove" value="Remove" onClick="funRemove()" style="width:100%" disabled>	
				<!--</a>-->
			</Td>
 		</Tr>
 		</Table>
</Div>

<Div id="buttonsDiv" style='Position:Absolute;WIDTH:100%;Top:90%'>
<%
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	buttonMethod.add("sendToselBox()");
	buttonMethod.add("window.close()");							                  							
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>
<Div id="image" style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
<br><br><br>
<Center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/retattachnostop.gif">
</Center>
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

<Div id="MenuSol">
</Div>
</form>
</body>
</html>
