<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
<%
		String pageUrl	=request.getParameter("pageUrl");
		String toFile = "";
		if("EditBackOrder".equals(pageUrl))
		{
			String fromDate	=request.getParameter("FromDate");
			String toDate	=request.getParameter("ToDate");
			String fromForm	=request.getParameter("FromForm");
			String concat	="&FromDate="+fromDate+"&ToDate="+toDate+"&FromForm="+fromForm;
			toFile 	= "../Sales/ezViewBackEndSalesDetails.jsp?Back=" + request.getParameter("Back")+"&status="+request.getParameter("status")+"&newFilter="+request.getParameter("newFilter")+concat ;
		}else
		{

			String fromDate=request.getParameter("FromDate");
			String toDate=request.getParameter("ToDate");
			String fromForm=request.getParameter("FromForm");
			String concat="&FromDate="+fromDate+"&ToDate="+toDate+"&FromForm="+fromForm;
			String SoldTo = request.getParameter("SoldTo");
			session.putValue("docSoldTo",SoldTo);
			toFile = "../Sales/ezBackEndSODetails.jsp?SONumber=" + request.getParameter("SONumber")+"&PODATE="+ request.getParameter("PODATE")+"&netValue="+request.getParameter("netValue") + "&orderType=" + request.getParameter("orderType")+"&status=" + request.getParameter("status")+"&newFilter="+request.getParameter("newFilter")+"&FromDate="+request.getParameter("FromDate")+"&ToDate="+request.getParameter("ToDate");
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
