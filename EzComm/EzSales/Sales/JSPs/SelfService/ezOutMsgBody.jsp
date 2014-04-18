<%
	String addSubUser = request.getParameter("addSubUser");
%>
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
	function createSubUser()
	{
		document.myForm.action="ezAddSubUser.jsp";
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
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
	<div class="col-main roundedCorners containerds">
	<div class="info-box">
<%
	String outMsg = (String)session.getValue("EzMsg");
	
	String outMsgL = (String)session.getValue("EzMsgL");

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
<%
	if("Y".equals(addSubUser))
	{
%>
	<div class="buttons-set form-buttons">
		<button type="button" class="button" title="Clear" value='Clear' onClick="createSubUser()" /><span>Create New Sub User</span></button>
	</div>
<%
	}
%>
	</div> <!-- col-main -->
<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
	<div class="block-title"><strong><span>My Account</span></strong></div>
	<div class="block-content">
	<ul>
		<li><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>
		<li ><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>
<%
	if(outMsgL!=null && "ADD".equals(outMsgL))
	{
%>
		<div style="color:#66cc33;"><strong><span>Add Sub Users</span></strong></div>
		<li><a href="../SelfService/ezListSubUsers.jsp">List Sub User</a></li>
<%
	}
	else if(outMsgL!=null && "EDIT".equals(outMsgL))
	{
%>
		<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
		<div style="color:#66cc33;"><strong><span>List Sub Users</span></strong></div>
<%
	}
%>
	</ul>
	</div>
	</div>
</div>
</div> <!--main -->
</div> <!-- main-container col2-left-layout -->
</form>
</body>