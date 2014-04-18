<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<title>Reason for Rejection --Powered By EzCommerce Global Solutions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
function show()
{
    document.myForm.comments.value=window.dialogArguments;
}
</script>
</head>
<body onLoad="show()" scroll=no>

<div id="CommentsDiv" style="position:absolute;top:0%;width:100%;visibility:visible">
	<Table align="center" width=100%>
	<Tr>
		<Td align="center" >
			<B>Reason for Rejecting the PO</B>
		</Td>
	</Tr>	
	<Tr>
		<Td align="center" class='blankcell'>
			<form name="myForm">
				<Textarea class="InputBox" rows=23 style='width:100%;font-size:11px' name="comments" readonly></Textarea>
			</form>	
		</Td>
	</Tr>
	</Table>
</div>

<div id="ButtonDiv" style="position:absolute;top:91%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Close");
	buttonMethod.add("window.close()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</body>
</html>
