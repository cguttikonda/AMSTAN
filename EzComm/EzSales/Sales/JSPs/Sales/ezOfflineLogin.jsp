<%
	String encryp = "salesOrder=0051723425&soldTo=0271000000&shipTo=0271000002&status=TRANSFERED";

	String webOrNo = request.getParameter("webOrNo");
	String soldTo = request.getParameter("soldTo");
	String sysKey = request.getParameter("sysKey");
	String status = request.getParameter("status");

	String salesOrder = request.getParameter("salesOrder");
	String shipTo = request.getParameter("shipTo");

	if(status==null || "null".equals(status))
		status = request.getParameter("negotiateType");

	StringTokenizer st = new StringTokenizer(encryp,"&");

	while(st.hasMoreTokens())
	{
		String token = st.nextToken();
		StringTokenizer st1 = new StringTokenizer(token,"=");

		while(st1.hasMoreTokens())
		{
			String token1 = st1.nextToken();
			String token2 = st1.nextToken();

			if("webOrNo".equals(token1))
				webOrNo = token2;
			if("soldTo".equals(token1))
				soldTo = token2;
			if("sysKey".equals(token1))
				sysKey = token2;
			if("status".equals(token1))
				status = token2;
			if("salesOrder".equals(token1))
				salesOrder = token2;
			if("shipTo".equals(token1))
				shipTo = token2;
		}
	}

//out.println("webOrNo:::::::::"+webOrNo+":::::soldTo::::::"+soldTo+":::::::::sysKey:::::::"+sysKey);	
	boolean sNew = session.isNew();
//out.println("sNew:::::::::"+sNew);	

	if(sNew)
	{
%>
		<Html>
		<Head>
		<TITLE>American Standard : Powered by EzCommerce Global Solutions</TITLE>
		<Script src="../../Library/Script/popup.js"></Script> 
		<Script>
			function funSubmit()
			{
				Popup.showModal('modal1');
				document.myForm.action = "../../../../../ezLogin.jsp";
				document.myForm.submit();
			}
		</Script>
		</Head>
		<Body onload='funSubmit()'>
		<Form name=myForm method=post>
		<input type="hidden" name="OFFLINE" value="Y">
		<input type="hidden" name="webOrNo" value="<%=webOrNo%>">
		<input type="hidden" name="soldTo"  value="<%=soldTo%>">
		<input type="hidden" name="sysKey"  value="<%=sysKey%>">
		<input type="hidden" name="docStatus"  value="<%=status%>">

		<input type="hidden" name="salesOrder"   value="<%=salesOrder%>">
		<input type="hidden" name="shipTo"   value="<%=shipTo%>">
		
		<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:20%; text-align:center; display:none;">
				<img src="../../Library/images/loading.gif" width="100" height="100" alt="">
				<br>
				<font size=2><B>Your request is being processed. Please wait...</B></font>
		</div>
				
		</form>
		</boby>
		</html>
<%		
	
	}
	else
	{
%>
		<Html>
		<Head>
		<TITLE>American Standard : Powered by EzCommerce Global Solutions</TITLE>
		<Script src="../../Library/Script/popup.js"></Script> 
		<Script>
			function funSubmit()
			{
				Popup.showModal('modal1');
<%
				if("NEGOTIATED".equals(status) || "REJECTED".equals(status) )
				{
%>				
					document.myForm.action = 'ezNegotiateOrderDetails.jsp'
<%
				}
				else if("NEW".equals(status))
				{
%>
					document.myForm.action = 'ezEditSaveSalesOrderDetails.jsp'
<%
				}
				else if("SUBMITTED".equals(status))
				{
%>
					document.myForm.action = 'ezApprovalOrderDetails.jsp'
<%
				}
				else if("TRANSFERED".equals(status))
				{
%>
					document.myForm.action = 'ezSalesOrderDetails.jsp'
<%
				}
				else
				{
%>
					document.myForm.action = '../Misc/ezDashBoard.jsp'
<%
				}
%>
				document.myForm.submit();
			}
		</Script>	
		</Head>
		<Body onload='funSubmit()'>
		<Form name=myForm method=post>
		<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:20%; text-align:center; display:none;">
			<img src="../../Library/images/loading.gif" width="100" height="100" alt="">
			<br>
			<font size=2><B>Your request is being processed. Please wait...</B></font>
		</div>
		<br><br><br>

<%
		session.putValue("docSoldTo",soldTo);
		session.putValue("SalesAreaCode",sysKey);
		
%>
		<input type=hidden name="webOrNo" 	value="<%=webOrNo%>">
		<input type=hidden name="soldTo"  	value="<%=soldTo%>">
		<input type=hidden name="sysKey"  	value="<%=sysKey%>">
		<input type="hidden" name="docStatus"   value="<%=status%>">
		<input type="hidden" name="salesOrder"   value="<%=salesOrder%>">
		<input type="hidden" name="shipTo"   value="<%=shipTo%>">
		
		</form>
		</boby>
		</html>
<%
	}
%>