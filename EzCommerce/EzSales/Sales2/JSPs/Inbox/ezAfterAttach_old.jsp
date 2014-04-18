<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@include file="../../../Includes/Jsps/Lables/iAfterAttach_Lables.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
	<Title>Enter Shipments --Powered By EzCommerce Inc</title>
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
	<Table width="90%" align=left>
		<Tr><Td class="blankcell"><b><%=filesAttached_L%></b></Td></Tr>
		<Tr><Td class="blankcell"><hr></Td></Tr>
		<Tr><Td class="blankcell"><%=filesAttachedMsg1_L%>: </Td></Tr>
		<Tr><Td class="blankcell"><%=filename%></Td></Tr>
		<Tr><Td class="blankcell"><hr></Td></Tr>
		<Tr><Td class="blankcell"><%=filesAttachedMsg2_L%></Td></Tr>
		<Tr><Td class="blankcell"><input type="button" name="Done" value="Done" onclick="funClose()"></Td></Tr>
		<Tr><Td class="blankcell"><hr></Td></Tr>
	</Table>
<input type="hidden" name="n1" value="<%=filename%>" >
<input type="hidden" name="index" value='<%=session.getValue("INDEX")%>' >
<Div id="MenuSol">
</Div>
</form>
</body>
</html>
