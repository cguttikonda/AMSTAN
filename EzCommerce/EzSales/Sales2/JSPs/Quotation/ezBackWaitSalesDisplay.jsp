<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
<%
		String pageUrl	= request.getParameter("pageUrl");
		String toAct	= request.getParameter("toAct");
		String orderStatus = request.getParameter("orderStatus");
		String fromDate	= request.getParameter("FromDate");
		String toDate	= request.getParameter("ToDate");
		String sapSoNo	= request.getParameter("sapSoNo");

		String toFile = "";
		if("SubmittedOrder".equals(pageUrl))
		{
			String SoldTo = request.getParameter("SoldTo");
			session.putValue("docSoldTo",SoldTo);
			toFile = "../Quotation/ezBackEndQuoteDetails.jsp?SONumber="+request.getParameter("SONumber")+"&toAct="+toAct+"&orderStatus="+orderStatus+"&FromDate="+fromDate+"&ToDate="+toDate+"&sapSoNo="+sapSoNo;
		}
%>
	function fun1()
	{
		document.location.replace("<%=toFile%>");		
	}
</script>
</head>
<body onLoad="fun1()" onContextMenu="return false">
<br><br><br>
<center><img src="../../Images/Buttons/<%= ButtonDir%>/pleasewait.gif"></center>
<Div id="MenuSol"></Div>
</body>
</html>
