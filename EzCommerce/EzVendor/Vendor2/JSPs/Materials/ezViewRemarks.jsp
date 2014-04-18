<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Reason for Rejection--Powered By EzCommerce India</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>  
<script>
function closeWindow()
{
	window.returnValue=document.myForm.comments.value;
	this.close()
}

function show()
{
    document.myForm.comments.value=window.dialogArguments;
}
</script>
</head>

<body onLoad="show()" onUnLoad="closeWindow()">
<form name="myForm">
<table align="center">
<tr><td align="center">
<Textarea style="overflow:auto;border:0" rows="15" cols="40" name="comments" readonly>
</Textarea>
</td></tr>
</Table>

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
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
