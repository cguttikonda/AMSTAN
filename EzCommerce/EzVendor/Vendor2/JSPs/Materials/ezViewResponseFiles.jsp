<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iViewResponseFiles.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%
    if(filesCount==0)	
    {
%>
<html>
<body>   <br><br>
	  <table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
	  <tr>
	  <td class="displayheader" align=center>No Files Uploaded</td>
	  </tr>
	  </table>
<br>
<center><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" onClick="window.close()"></center>
</body>
</html>

<%
   }else{	
%>

<html>
<head>
<title>View Attached Files</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var documentTypes = new Array()

function setData(code,description)
{
	this.code = code
	this.description = description

}

documentTypes[0] = new setData("COA","COA Document")
documentTypes[1] = new setData("STP","STP Document")

</script>


<script>

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

<%
   for(int i=0;i<filesCount;i++)
   {
%>
	<script>
	var display=false;
	for(j=0;j<documentTypes.length;j++)
	{
	    if('<%=retFiles.getFieldValueString(i,"TYPE")%>'==documentTypes[j].code)		
	    {
		display = true;   
		break;
	    }
	
	}
	
	if(display)
	{
	   document.write("<tr>");
	   document.write("<td width=50%>"+documentTypes[j].description+"</td>");
	   //document.write("<td width=50%><a href='ezViewUploadedFile.jsp?fileName=<%=retFiles.getFieldValueString(i,"SERVERFILENAME")%>'><%=retFiles.getFieldValueString(i,"CLIENTFILENAME")%></a></td>");
	    document.write("<td width=50%><input type='hidden' name='upFile"+j+"' value='<%=retFiles.getFieldValueString(i,"SERVERFILENAME")%>'><a href='javascript:funOpenFile("+j+")'><%=retFiles.getFieldValueString(i,"CLIENTFILENAME")%></a></td>");
           document.write("</tr>");
	}
	</script>

<% }  %>

</table>

<br><br><br><br>
<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none style="cursor:hand" onClick="window.close()">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
<% }%>
