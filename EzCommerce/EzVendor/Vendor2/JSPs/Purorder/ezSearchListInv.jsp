<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function fun1()
	{
		document.location.replace("ezListInv.jsp?searchField=<%=request.getParameter("searchField")%>&base=<%=request.getParameter("base")%>&InvStat=<%=request.getParameter("InvStat")%>")
	}
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="fun1()" onContextMenu="return  false">
<form>
<center>
<br>
<br>
<br>
<br>
<Center><b>Retrieving data... Please wait</Center>
<br>
<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>