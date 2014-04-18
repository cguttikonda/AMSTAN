<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function fun1()
	{
		document.location.replace("ezPOInvoices.jsp?PurchaseOrder=<%=request.getParameter("PurchaseOrder")%>&base=<%=request.getParameter("base")%>&orderCurrency=<%=request.getParameter("orderCurrency")%>&OrderValue=<%=request.getParameter("OrderValue")%>&GRNo=<%=request.getParameter("GRNo")%>");
	}
</script>
</head>

<body bgcolor="#FFFFF7" onLoad="fun1()" onContextMenu="return  false">
<form>
<center>
<br>
<br>
<br>
<br>
<Center>Retrieving data... Please wait</Center>
<br>
<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
