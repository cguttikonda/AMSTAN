<% //@ include file="../../Library/Globals/CacheControl.jsp"%>
<html>
<head>
<script>
<%
	String toFile ="../Config/ezListSystems.jsp";
%>
	function fun1()
	{
		document.location.replace("<%=toFile%>");
	}
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="fun1()" onContextMenu="return  false">

</body>
</html>