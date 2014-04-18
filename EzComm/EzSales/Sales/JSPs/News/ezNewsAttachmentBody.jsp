<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	String[] attachedFiles=request.getParameterValues("attachedFiles");
%>
<html>
<head>
	<title>Mail Attachments</title>
			
     	<script language="JavaScript">
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

/*function doAttach()
{
	var s="";
	alert(document.myForm.attachList.length)
	if(document.myForm.attachList.length > 0)
		s=s+document.myForm.attachList.options[0].value;
	alert("s::::::::::::::::::::"+s)	
	for(var i=1;i<document.myForm.attachList.length;i++)
	{
		s = s +"\n"+document.myForm.attachList.options[i].value;
	}
	alert(eval("parent.opener.myForm.attached"))
	parent.opener.myForm.attached.value=s;
	alert(s)
	window.close();
}*/
function sendToselBox()
{
	
	var parentObj="";
	var docObj="";
	if(!document.all)
	{
		parentObj = opener.document.myForm
		docObj = opener.document
	}
	else
	{
		parentObj = parent.opener.myForm
		docObj = parent.opener.document
	}	
	
	var len=docObj.myForm.attachs.length
	var len=document.myForm.attachList.length;
	
	if(len!=null)
	{
		if(!isNaN(len))
		{
			for(var i=0;i<len-1;i++)
			{
				filesStr = document.myForm.attachList.options[i].value;
				if(window.navigator.appName =="Microsoft Internet Explorer")
				{
					var newOpt = docObj.createElement("OPTION")
					newOpt.value=filesStr;
					newOpt.text=filesStr;
					docObj.myForm.attachs.add(newOpt)
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
		//alert("attachedFiles::::::"+attachedFiles)
		if(flag)
		{
			alert("File with this name is already attached")
		}
		else
		{
			document.myForm.action="../Inbox/ezUploadFiles.jsp?attachList="+attachedFiles+"&flag=N"
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

			document.myForm.action="../Inbox/ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles+"&flag=N"
			document.myForm.submit();
		}
	}
}

function doCancel()
{
   document.temp1.action="../Inbox/ezAttachment.jsp?operation=cancel";
   document.temp1.submit();
}
     	
 function setDefaults()
	{
<%
		if(attachedFiles != null)
		{
			for(int i=0;i<attachedFiles.length;i++)
			{
%>
				document.myForm.attachList.options[<%=i%>]=new Option("<%=attachedFiles[i]%>","<%=attachedFiles[i]%>")
<%
			}
		}
%>
	}
   	</script>
</head>
<body onLoad="setDefaults()">
<form name="myForm" ENCTYPE="multipart/form-data" method="POST" >
	<Table  border="0" cellpadding="0" cellspacing="0">
	<Tr>
    		<Td width="160" valign="top" rowspan=2>
    			<Table  border=0 cellpadding=2 cellspacing=0 width=100% align=center>
    			<Tr>
    			</Tr>
    			</Table ><p>
    		</Td>
    	</Tr>
    	<Tr valign=top><Td width="100%" valign=top >
    	<br>
   	<Table  border=0 cellspacing=0 cellpadding=0 width=100%>
	<Tr>
	<Td width=15 rowspan=7></Td>
	<Td colspan=5>
		<font >Attach a file to your message in two steps, repeating the steps as needed to attach multiple files. Click <b>done</b> to return to your message when you are done.</font>
		<br><br>
	   	</Td>
		</Tr>
		<Tr>
	   		<Td style="padding:2px;" valign="top"><font >1.</font></Td>
	   		<Td style="padding:2px; padding-right:15px;" width="48%" valign="top"><font >Click <b>Browse</b> to select the file, or type the path to the file in the box below.</font></Td>
	   		<Td style="padding:2px;" valign="top"><font >2.</font></Td>
           		<Td style="padding:2px;" width="48%" colspan=2><font >Move the file to the <b>Attachments</b> box by clicking <b>Attach</b>.</font> <font class="s">File Transfer times vary (30 seconds up to 10 minutes).</font><br><br></Td>
		</Tr>
   		<Tr>
	   	<Td></Td>
	   	<Td style="padding-right:15px;" rowspan=2 valign="top">
	   	   	<font  style="font-size:13px"><label for="attFbutton" >Attach File</label>:</font><br>
	   	   	<input type="file"  name="attachFile" id="attFbutton" tabindex="1">
	      		<br>
	   	</Td>
	  	<Td></Td>
	  	<Td></Td>
	  	<Td><font  style="font-size:13px"><label for="attachList">Attachments</label>:</font></Td>
		</Tr>
		<Tr>
	  	<Td></Td>
	  	<Td></Td>
	  	<Td align="center" valign="top">
			<a href="javascript:doAttachFile()">Attach</a>
		<p>
		<a href="javascript:doRemove()">Remove</a>
		</Td>
		<Td valign="top">
			<select class = "control" name="attachList" tabindex="4" size=5 multiple>
   	        </select>
	       <br>
	  </Td>
	  </Tr>
  	<Tr>
	<!--<Td colspan=5 align="right">
		<button type="submit" class="button" value="Save" title="Save" onClick="sendToselBox()"/><span>Done</span></button>&nbsp;
		<button type="submit" class="button" value="cancel" title="cancel" onClick="javascript:window.close()"/><span>Cancel</span></button>
  	</Td>-->
  	<Td colspan=5 align=right>
			<hr size="1" color="#8CA5B5" width="100%">
				<button type="submit" class="button" value="Save" title="Save" onClick="sendToselBox()"/><span>Done</span></button>&nbsp;
			&nbsp;
			<button type="submit" class="button" value="cancel" title="cancel" onClick="javascript:window.close()"/><span>Cancel</span></button>
  	</Td>
	</Tr>
</Table>
	</Td>
	</Tr></Table >
	</Td>
	</Tr>
	</Table >

</form>
   </body>
</html>
