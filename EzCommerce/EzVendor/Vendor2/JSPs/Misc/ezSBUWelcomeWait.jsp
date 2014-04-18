<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function reDirectPage()
	{
		document.body.style.cursor='wait'
		document.location.href="ezSBUWelcome.jsp";
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

</body>
</html>
