<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iPassword_Labels.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iSavePassword.jsp"%>
<%
	String display_header = "Save Password";
	String noDataStatement = urPwdSucc_L;
%>
		
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body scroll=no>
<%@ include file="ezDisplayHeader.jsp"%>
<%@ include file="ezDisplayNoData.jsp" %>
<Div id="ButtonDiv" style="position:absolute;top:90%;visibility:visible;width:100%">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Ok");
	buttonMethod.add("navigateBack(\"ezSBUWelcome.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));	
%>
</Td>
</Tr>
</Table>
</div>
<Div id="MenuSol"></Div>
</body>
</html>
