<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/Labels/iAttachFile_Labels.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<title>File Attachments --Powered By EzCommerce Inc</title>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
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
	   	//alert("fileName = "+ fileName)
	   	//eval('document.myForms.n'+j).value=fileName
	}

	function funClose()
	{
		var path = document.myForms.f1.value
		var fileNameAtted_L = '<%=fileNameAtted_L%>';
		var browseFile_L = '<%=browseFile_L%>';
		if(funTrim(path)=="")
		{
			alert(browseFile_L);
			return false;
		}
		else
		{
			
			var x = path.lastIndexOf('\\')
			
			var fileName=path.substring(x+1,path.length);
			var len=docObj.myForm.attachs.length
			//alert(len);
			for(var i=0;i<len;i++)
			{
				//alert(parentObj.attachs.options[i].value+"****"+fileName)
				if(parentObj.attachs.options[i].value==fileName)
				{
					alert(fileNameAtted_L)
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
<body scroll=no>
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
	<Center><b>Attaching File... Please wait</Center>
	<br>
	<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
