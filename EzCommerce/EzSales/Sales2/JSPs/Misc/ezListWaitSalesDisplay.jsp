
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
<%
	String toFile = "../Sales/ezDisplay.jsp?webOrNo=" + request.getParameter("webOrNo")+"&soldTo="+request.getParameter("soldTo")+"&sysKey="+request.getParameter("sysKey")+"&newFilter="+request.getParameter("newFilter");
%>
	function fun1()
	{
		document.location.replace("<%=toFile%>");
	}
</script>
</head>
<body onLoad="fun1()" onContextMenu="return  false" scroll=no>
<br><br><br><br>
<center><img src="../../Images/Buttons/<%= ButtonDir%>/pleasewait.gif"></center> 
<Div id="MenuSol"></Div>
</body>
</html>
