<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iSendRejectedMatMail_Labels.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%

	String msgSubject=request.getParameter("msgSubject");
	String msgText=request.getParameter("msgText");
	String sendToUser = request.getParameter("toUser");
	String noDataStatement = mailSentSP_L;
%>
<%//@include file="../Purorder/ezSendAckMail.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body>
<%@include file="../Misc/ezDisplayNoData.jsp" %>

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("navigateBack(\"../Materials/ezListRejectedMaterials.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<Div id="MenuSol"></Div>
</body>
</html>

