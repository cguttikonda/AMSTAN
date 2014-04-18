<script type="text/javascript">
	function getDetails(PoNum,SoldTo,ShipTo,PoDate,Print)
	{
		document.myForm.poNo.value=PoNum;
		document.myForm.soldTo.value=SoldTo;
		document.myForm.shipTo.value=ShipTo;
		document.myForm.poDate.value=PoDate;
		document.myForm.OrdPrint.value=Print;

		document.myForm.action="ezSalesOrderDetails.jsp";
		document.myForm.submit();
	}
</script>
<body>
<form name="myForm" method="post">
<input type="hidden" name="poNo">
<input type="hidden" name="soldTo">
<input type="hidden" name="shipTo">
<input type="hidden" name="poDate">
<input type="hidden" name="OrdPrint">
<div class="main-container col2-layout middle account-pages">
<div class="main">
	<div class="col-main1 roundedCorners">
	<div class="info-box">
<%
	if(session.getValue("DUPREQ")!=null)
		session.removeValue("DUPREQ"); 

	String outMsg = (String)session.getValue("EzMsg");

	if(outMsg!=null && outMsg.indexOf("Error")!=-1)
	{
%>
		<ul class="error-msg"><li><span><%=outMsg%></span></li></ul>
<%
	}
	else
	{
%>
		<ul class="success-msg"><li><span><%=outMsg%></span></li></ul>
<%
	}
%>
	</div>
	</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>