<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Jsps/Labels/iAttachFile_Labels.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/Trim.js"></script>
<title>File Attachments --Powered By EzCommerce Inc</title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
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

	function openBrowse(i){
		eval("document.myForms.f"+i).click()
	}
	function setFname(j){
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
			var dotPos 		= path.lastIndexOf('.');
			var fileExt	= path.substring(dotPos+1,path.length);
			//alert(fileExt);
			
			
			if(!(fileExt == "ppt" || fileExt == "htm" || fileExt == "zip" || fileExt == "html" || fileExt == "tif" || fileExt == "pdf" || fileExt == "doc" || fileExt == "xls"))
			{
				alert("Please attach only files of below given file types \n --- Excel , Word , PDF Documents \n --- Html, Tif and Zip Files");
				return;
			}


			
			var x 		= path.lastIndexOf('\\')
			var fileName	= path.substring(x+1,path.length);
			var len		= docObj.myForm.attachs.length
			//alert(len);
			for(var i=0;i<len;i++)
			{
				//alert(parentObj.attachs.options[i].value+"****"+fileName)
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
<body>
<%
	String index=request.getParameter("index");
	session.putValue("INDEX",index);
%>
<form name="myForms" ENCTYPE="multipart/form-data" method="POST" >
<div id="attachment" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<TABLE border=0 width="95%" align="left">
  		<tr><td class="blkankcell"><b><%=attachFile_L%></b></td>
  		<Tr><td class="blankcell"><hr></Tr>
 		 <Tr><td class="blankcell">1. <b><%=findFile_L%></b></Td></Tr>
  		<Tr><td class="blankcell"><%=attachMsg1_L%></td></Tr>
 		<Tr><td class="blankcell"><input type=file   value="" name="f1" onPropertyChange="setFname(1)"></td></Tr>
 		 <Tr><td class="blankcell"><hr></Tr>
 		 <Tr><td class="blankcell">2. <b><%=addFile_L%></b></Td></Tr>
 		 <Tr><td class="blankcell"><%=attachMsg2_L%></Td></Tr>
 		 <Tr><td class="blankcell"><input type="button" name="done" value="Add File" onClick="funClose()" ></Td></Tr>
 		 <Tr><td class="blankcell"><hr></Tr>
</Table>
</div>
<div id="image" style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
<br><br><br>
<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/retAttachNoStop.gif">
</center>
</div>
<Div id="MenuSol">
</Div>
</form>
</body>
</html>
