<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/JSPs/Lables/iAttachFile_Lables.jsp"%>


<html>
<head>
	<Title>File Attachments --Powered By EzCommerce Inc</Title>
	<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<script>
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

	function openBrowse(i)
	{
		eval("document.myForms.f"+i).click()
	}
	function setFname(j)
	{
		var path = eval('document.myForms.f'+j).value
		var x = path.lastIndexOf('\\')
		var fileName=path.substring(x+1,path.length);
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
			var dotPos 		= path.lastIndexOf('.');
			var fileExt	= path.substring(dotPos+1,path.length);
			
			var x 		= path.lastIndexOf('\\')
			var fileName	= path.substring(x+1,path.length);
			var len		= docObj.myForm.attachs.length
			for(var i=0;i<len;i++)
			{
				if(parentObj.attachs.options[i].value==fileName)
				{
					alert("File With This Name is Already Attached")
					return;
				}
			}
			
			document.getElementById("attachment").style.visibility="hidden";
			setTimeout("funWait()","200");
			document.myForms.action="ezUploadFiles.jsp";
			document.myForms.submit();
		}
	}

	function funWait()
	{
		document.getElementById("image").style.visibility="visible";
		document.body.style.cursor='wait'
	}

</script>
</head>
<Body  scroll=no>
<%
	String index=request.getParameter("index");
	session.putValue("INDEX",index);
%>
<Form name="myForms" ENCTYPE="multipart/form-data" method="POST">
	<div id="attachment" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<TABLE border=0 width="95%" align="left">
		<Tr>
			<Td class="blkankcell"><b><%=attachFile_L%></b></Td>
		<Tr>
			<Td class="blankcell"><hr>
		</Tr>
		<Tr>
			<Td class="blankcell">1. <b><%=findFile_L%></b></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><%=attachMsg1_L%></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><input type=file   value="" name="f1" onPropertyChange="setFname(1)"></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><hr>
		</Tr>
		<Tr>
			<Td class="blankcell">2. <b><%=addFile_L%></b></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><%=attachMsg2_L%></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><input type="button" name="done" value="Add File" onClick="funClose()" ></Td>
		</Tr>
		<Tr>
			<Td class="blankcell"><hr>
		</Tr>
	</Table>
	</Div>
<Div id="image" style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<br><br><br>
	<center>
		<img src="../../Images/Buttons/<%=ButtonDir%>/retAttachNoStop.gif">
	</center>
</Div>
<Div id="MenuSol">
</Div>
</Form>
</Body>
</html>
