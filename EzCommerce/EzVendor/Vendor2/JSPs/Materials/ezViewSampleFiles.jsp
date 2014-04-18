<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iViewSampleFiles.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp"%>
<html>
<head>
<title>View Attached Files</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
var documentTypes = new Array()

function setData(code,description)
{
	this.code = code
	this.description = description

}

documentTypes[0] = new setData("PFD","Process Flow Diagram")
documentTypes[1] = new setData("REACTMECH","Reaction Mechanism")
documentTypes[2] = new setData("SPEC","Specification")
documentTypes[3] = new setData("PROCDESC","Brief Description of Process")
documentTypes[4] = new setData("METOFANAL","Method Of Analysis")
documentTypes[5] = new setData("MATSAFETY","Material Safety Data Sheet")
documentTypes[6] = new setData("STABLEDATA","Stability Data")
documentTypes[7] = new setData("DCDOC","DC Document")
documentTypes[8] = new setData("LRDOC","LR Document")
documentTypes[9] = new setData("PACKDOC","Packing Document")
documentTypes[10] = new setData("INVDOC","Invoice (Excise) Document")
documentTypes[11] = new setData("IMPPROFILE","Impurity Profile")
documentTypes[12] = new setData("SOLVENT","Solvent - List")
documentTypes[13] = new setData("CHROMOTOGRAM","Chromotogram")
documentTypes[14] = new setData("COADOC1","COA Document1")
documentTypes[15] = new setData("COADOC2","COA Document2")
documentTypes[16] = new setData("COADOC3","COA Document3")


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
<br>
<center><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none style="cursor:hand" onClick="window.close()"></center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
