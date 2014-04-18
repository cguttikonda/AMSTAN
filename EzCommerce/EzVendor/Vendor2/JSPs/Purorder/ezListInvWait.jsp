<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
<%
	String invFlag=request.getParameter("InvStat");
	String toFile = null;
	if(invFlag.equals("O"))
		toFile = "ezListOPENInvoices.jsp";
	else
		toFile = "ezListInv.jsp";
            

%>
	function reDirectPage()
	{
		document.body.style.cursor='wait'
                document.location.replace("<%=toFile%>?InvStat=<%=invFlag%>&PurchaseOrder=<%=request.getParameter("PurchaseOrder")%>");
               
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
<Div id="MenuSol"></Div>
</body>
</html>
