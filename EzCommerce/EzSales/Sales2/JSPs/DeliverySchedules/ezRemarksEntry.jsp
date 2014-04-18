<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iRemarks_Lables.jsp" %>
<%
String ind=request.getParameter("ind");
String fieldName=request.getParameter("fieldName");
///out.println(fieldName);
%>
<html>
<head>

<title>Remarks</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
docPath=""

if (document.all)
{
	 docPath=parent.opener.document.<%=fieldName%>
}
else
{
	docPath=opener.document.<%=fieldName%>
}
	function closeWindow1()
	{
		y=docPath
		y.value=document.f1.comments.value;
		//window.returnValue=document.f1.comments.value

		window.close()
	}

	function closeWindow2()
	{
		window.close()
	}

	function show()
	{
		y=docPath
		
		if(y != null && y.value != null && y.value != 'undefined')
			document.f1.comments.value=y.value;
		/*if(parent.dialogArguments != null )
		document.f1.comments.value=parent.dialogArguments*/
	}

</script>
</head>
<body class=welcomebody onLoad="show()">
<form name="f1">
<table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr><th> Enter your Remarks here and press Ok ...</th></tr>
	<tr><td align="center">
	<Textarea rows="10" cols="35" class=txarea name="comments">
	</Textarea>
	</td></tr>
</table>
<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("closeWindow1()");
	buttonName.add("Cancel");
	buttonMethod.add("closeWindow2()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
