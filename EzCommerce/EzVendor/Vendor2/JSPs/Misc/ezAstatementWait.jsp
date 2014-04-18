<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iAstatement_Labels.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function reDirectPage()
	{
		document.location.replace("ezAstatement.jsp?FromForm=<%=request.getParameter("FromForm")%>&FromDate=<%=request.getParameter("FromDate")%>&ToDate=<%=request.getParameter("ToDate")%>&ShowData=<%=request.getParameter("ShowData")%>");
	}
</script>
</head>
<body onLoad="reDirectPage()" onContextMenu="return  false">
<Div class="waitDiv">
<center>
	Retrieving data... Please wait
	<BR><BR>
	<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>