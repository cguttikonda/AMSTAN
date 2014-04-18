<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
function ezHref(param)
{
	document.myForm.action=param;
	document.myForm.submit();
}
	
</script>
</head>
<body bgcolor="#FFFFF7" scroll=no>
<form name="myForm">
<%
	
	
	String noDataStatement = request.getParameter("Msg");
	if(noDataStatement!=null && noDataStatement.indexOf("¥")!=-1){
		noDataStatement = replaceStr(noDataStatement,"¥","<BR>");
	}
	
%>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>

<br><br>
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center><!--<a href="../Misc/ezSBUWelcome.jsp"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Ok");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
