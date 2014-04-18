<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<script>
<%

	String toFile = null;
		//toFile = "ezSBUWelcome.jsp";
		toFile = "ezQCFSAPPrint.jsp";
%>
	function fun1()
	{
		document.body.style.cursor='wait'
		document.location.replace("<%=toFile%>");
	}
</script>
</head>
<%
        // Clearing the Cache
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<body bgcolor="##C7D7DE" onLoad="fun1()" onContextMenu="return  false">
<form>
<center>
<br>
<br>
<br>
<br>
<br>
<!--<img src="../../Images/Buttons/<%=ButtonDir%>/retDataNoStop.gif">-->
</center>
<Div id="MenuSol"></Div>
</form>
</body>
</html>