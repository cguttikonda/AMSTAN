<html>
<%
	String status = request.getParameter("status");	
	String selectedRfq = request.getParameter("CollectiveRfq");
	String selectedTime = request.getParameter("TimePeriod");		
%>

	<frameset cols=60%,40%">
<%

	if("QBV".equals(status))
	{
%>
		<frame name=f1 src="ezPieReportGenerator.jsp?status=<%=status%>&CollectiveRfq=<%=selectedRfq%>&Report=B"  scrolling="no" frameborder="0" noresize/>
<%
	}
	else if("VQH".equals(status))
	{
%>
		<frame name=f1 src="ezPieReportGenerator.jsp?status=<%=status%>&TimePeriod=<%=selectedTime%>&Report=B"  scrolling="no"  frameborder="0" noresize/>
<%
	}
%>
		<frame name=f2 src="ezPieReportStatstics.jsp?status=<%=status%>&CollectiveRfq=<%=selectedRfq%>&TimePeriod=<%=selectedTime%>&Report=B"  scrolling="no"  frameborder="0" noresize/>
	</frameset>
<Div id="MenuSol"></Div>
</html>