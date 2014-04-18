<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iVendorProfile_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iViewProfileFiles.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp"%>

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

documentTypes[0] = new setData("MFGLIC","Manufacturing License")
documentTypes[1] = new setData("FDA","FDA Document")
documentTypes[2] = new setData("ISO","ISO Document")
documentTypes[3] = new setData("WHO","WHO Document")

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
  window.open("../Misc/ezViewFile.jsp?filename=<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")	
  //document.location.href="/<%=uploadFilePathDir%>"+sFile
}

</script>


</head>

<body scroll=no>
<form name="myForm">
<table width="100%">
<tr><td><b><%=attachFiles_L%></b></td></tr>
<tr><td class="blankcell"><hr></td></tr>
</table>

<table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
<th width=50%><%=docType_L%></th>
<th width=50%><%=fileName_L%></th>
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
<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none style="cursor:hand" onClick="window.close()"> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Ok");
		buttonMethod.add("window.close()");
		
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
