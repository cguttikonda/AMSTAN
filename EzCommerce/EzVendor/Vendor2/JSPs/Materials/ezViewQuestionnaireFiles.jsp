<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp"%>

<html>
<head>
<title>View Attached Files</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

function funOpenFile(serverFileInd)
{

  serverFile = eval("document.myForm.upFile"+serverFileInd).value
  var fVal = serverFile.split('*')
  sFile="";
  for(var i=0;i<fVal.length;i++)
  {
      sFile = sFile+fVal[i]+"/"
  }  	
  sFile = sFile.substring(0,sFile.length-1)
  window.open("/<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")	
  //document.location.href="/<%=uploadFilePathDir%>"+sFile
}

</script>
</head>

<body >
<form name="myForm">
<table width="100%">
<tr><td><b>Attached Files</b></td></tr>
<tr><td class="blankcell"><hr></td></tr>
</table>

<table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
<th width=50%>Document Type</th>
<th width=50%>File Name</th>
</tr>

	<tr>
	<td width=50%>Letter Of Undertaking</td>
<script>
	var fileName=parentObj.fileName.value
	var serverFileName=parentObj.serverLou.value
	//document.write("<td width=50%><a href='ezViewUploadedFile.jsp?fileName="+fileName+"'>"+fileName+"</a></td>");
       document.write("<td width=50%><input type='hidden' name='upFile1' value='"+serverFileName+"'><a href='javascript:funOpenFile(1)'>"+fileName+"</a></td>");

</script>
        </tr>
</table>

<br><br><br><br>
<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none style="cursor:hand" onClick="window.close()">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
