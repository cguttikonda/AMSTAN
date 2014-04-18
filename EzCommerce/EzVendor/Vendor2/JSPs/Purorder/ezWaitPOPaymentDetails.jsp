<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iWaitPOPaymentDetails_Labels.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function fun1()
	{
		document.location.replace("ezPOPaymentDetails.jsp?PurchaseOrder=<%=request.getParameter("PurchaseOrder")%>&base=<%=request.getParameter("base")%>&base1=<%=request.getParameter("base1")%>&orderCurrency=<%=request.getParameter("orderCurrency")%>&OrderValue=<%=request.getParameter("OrderValue")%>");
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
<Center><%=retPlzWait_L%></Center>
<br>
<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
