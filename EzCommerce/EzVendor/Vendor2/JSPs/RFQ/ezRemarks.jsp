<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<html>
<head>
<title>Remarks-- Powered By Answerthink</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=96
	var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>

function funRemarks()
{
	var reasons = document.myForm.reasons.value;	
	if(funTrim(reasons)!='')
	{
		window.returnValue=funTrim(reasons);
		window.close();
	}
	else
	{
		alert("Please enter Reasons");
		document.myForm.reasons.focus();
	}
}

function funCancel()
{
	window.returnValue="Canceld~~"
	window.close()
}
</script>
</head>
</head>
<body scroll="no">
<form name="myForm">
<br>
<table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr><th> Enter Reasons here and press Ok ...</th></tr>
	<tr><td align="center">
	<Textarea rows="13" cols="70" class=txarea name="reasons"></Textarea>
	</td></tr>
</table>
<br>
<Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">
 <%
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	butActions.add("funRemarks()");
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	butActions.add("funCancel()");
	out.println(getButtons(butNames,butActions));
%>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

