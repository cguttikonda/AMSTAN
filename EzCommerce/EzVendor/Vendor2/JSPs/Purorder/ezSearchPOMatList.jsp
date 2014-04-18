<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function fun1()
	{
		 document.location.replace("ezListPOs.jsp?SearchFlag=<%=request.getParameter("SearchFlag")%>&MaterialNumber=<%=request.getParameter("MaterialNumber")%>");
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