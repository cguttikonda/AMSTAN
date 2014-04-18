<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Enter Shipments --Powered By EzCommerce Inc</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
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


function funClose()
{
	var index=document.myForm.index.value;
	docObj.myForm.n1[index].value =document.myForm.n1.value;
	docObj.getElementById("remove"+index).style.visibility="visible"
	docObj.getElementById("attachment"+index).style.visibility="hidden"
	if(docObj.getElementById("textn1"+index)!=null)
	{
		docObj.myForm.n1[index].style.visibility="hidden";
		docObj.getElementById("textn1"+index).style.display="none"
		docObj.getElementById("textn2"+index).style.display=""
		docObj.getElementById("attach"+index).style.display="none"
		docObj.getElementById("del"+index).style.display=""
		docObj.myForm.n2[index].value=document.myForm.n1.value;
	}

	parent.window.close();
}
</script>
</head>
<form name=myForm>
<body>
<%
	String filename=request.getParameter("filename");
	String index=request.getParameter("index");
%>
<br>
<TABLE width="90%" align=left>
<tr><td class="blankcell"><b>Files Attached.</b></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">The following file have been attached: </Td></Tr>
<tr><td class="blankcell"><%=filename%></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">Click on the 'Done' button.</Td></Tr>
<tr><td class="blankcell"><input type="button" name="Done" value="Done" onclick="funClose()"></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
</table>
<input type="hidden" name="n1" value="<%=filename%>" >
<input type="hidden" name="index" value='<%=session.getValue("INDEX")%>' >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
