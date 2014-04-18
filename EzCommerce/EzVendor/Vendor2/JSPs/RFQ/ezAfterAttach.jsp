<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Jsps/Labels/iAfterAttach_Labels.jsp"%>
<html>
<head>
<title>Document Attachment --Powered By Answerthink India Pvt Ltd.</title>
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

function funClose()
{
	var len=docObj.myForm.attachs.length
	if(window.navigator.appName =="Microsoft Internet Explorer")
	{
		var newOpt = docObj.createElement("OPTION")
		newOpt.value=document.myForm.n1.value
		newOpt.text=document.myForm.n1.value
		docObj.myForm.attachs.add(newOpt)
	}
	else
	{
		parentObj.attachs.options[len]=new Option(document.myForm.n1.value,document.myForm.n1.value);
	}
	window.close();
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
<tr><td class="blankcell"><b><%=filesAttached_L%></b></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell"><%=filesAttachedMsg1_L%>: </Td></Tr>
<tr><td class="blankcell"><%=filename%></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell"><%=filesAttachedMsg2_L%></Td></Tr>
<tr><td class="blankcell"><input type="button" name="Done" value="Done" onclick="funClose()"></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
</table>
<input type="hidden" name="n1" value="<%=filename%>" >
<input type="hidden" name="index" value='<%=session.getValue("INDEX")%>' >
<Div id="MenuSol">
</Div>
</form>
</body>
</html>
