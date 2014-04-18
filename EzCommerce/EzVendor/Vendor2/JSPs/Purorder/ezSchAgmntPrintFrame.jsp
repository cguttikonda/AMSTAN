<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<Title>POPrint--Powered by EzCommerce Inc</Title>
</head>
<frameset rows="90%,10%" frameborder=0>
<frame src="ezSchAgmntPrint.jsp?purorder=<%=request.getParameter("purorder")%>&FromDate=<%=request.getParameter("fromDate")%>&ToDate=<%=request.getParameter("toDate")%>" frameborder=0>
<frame src="ezPrint.jsp" frameborder=0 scrolling="NO">
</frameset>
<Div id="MenuSol"></Div>
</html>
