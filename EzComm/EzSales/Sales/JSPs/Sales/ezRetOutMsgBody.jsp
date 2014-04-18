<script type="text/javascript">
	function getDetails(PoNum,SoldTo,ShipTo,PoDate)
 	{
		document.myForm.poNo.value=PoNum;
		document.myForm.soldTo.value=SoldTo;
		document.myForm.shipTo.value=ShipTo;
		document.myForm.poDate.value=PoDate;
 
 		document.myForm.action="ezSalesOrderDetails.jsp";
 		document.myForm.submit();
 	}
	function funSubmit(rType)
	{
		document.myForm.rType.value=rType;
		document.myForm.action="ezCancellationRequestsMain.jsp";
		document.myForm.submit();
	}
</script>
<body>
<form name="myForm" method="post">
<input type="hidden" name="poNo">
<input type="hidden" name="soldTo">
<input type="hidden" name="shipTo">
<input type="hidden" name="poDate">
<input type="hidden" name="rType">
<div class="main-container col2-layout middle account-pages">
<div class="main">
	<div class="col-main1 roundedCorners">
 	<div class="info-box">
<%
 	String outMsg = (String)session.getValue("EzMsg");
 	String outMsgF = (String)session.getValue("EzMsgF");
 	String outMsgB = (String)session.getValue("EzMsgB");

	String outMsgH = (String)session.getValue("EzMsgH");
%>
	<h2 class="sub-title"><%=outMsgH%></h2>
<%
 	if(outMsg!=null && outMsg.indexOf("ERROR")!=-1)
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
 	<br>
 	<h2 class="sub-title"><B><Font color="RED"><%=outMsgF%></Font></B></h2>
 	<div class="buttons-set form-buttons">
 		<p class="back-link"><%=outMsgB%></p>
	</div>
 	</div>
 	</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>