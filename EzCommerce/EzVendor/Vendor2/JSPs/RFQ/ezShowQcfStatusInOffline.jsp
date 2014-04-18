<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iShowQcfStatus.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
<Title>Approval Hierarchy</Title> 

</head>
<body>
<form name="myForm">

<%
	String requestFrom = request.getParameter("requestFrom");
	String fontSize = "1";
	if("OFFLINE".equals(requestFrom))
		fontSize = "2";
	if(wfCount > 0)
	{
%>
	<Div style="position:absolute;width:100%;height:100%;top:0%;left:0%">
	<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellSpacing=1>
<%
	if(!("CEO".equals(sessionRole) || "CFO".equals(sessionRole)))
	{
%>		
		<Tr align="left">
			<Th width='40%'><Font size=<%=fontSize%>>Initiator</Font></Th>
			<Td><Font size=<%=fontSize%>><%=getUserName(Session,createdBy,"U",(String)session.getValue("SYSKEY"))%></Td></Font>
		</Tr>

<%
	}
%>
		<Tr align="left">
			<Th width='40%'><Font size=<%=fontSize%>>Current Status</Font></Th>
			<Td><Font size=<%=fontSize%>><%=currentStatus%></Font></Td>
		</Tr>
<%
	if(!("CEO".equals(sessionRole) || "CFO".equals(sessionRole)))
	{
%>
		<Tr align="left">
		<Th width='35%' valign='top' colspan=2><Font size=<%=fontSize%>>Work Flow Hierarchy</Font></Th>
		</Tr>
		<Tr>
		<Td colspan=2><Font size=<%=fontSize%> >
<%
			String approversList = "";
			int hashSize = approvedHash.size();
			for(int i=0;i<hashSize;i++)
			{
				if(approvedHash.get(i+"") != null)
				{
					approversList = (String)approvedHash.get(i+"");
					java.util.StringTokenizer stoken = new java.util.StringTokenizer(approversList,"¥");
					appRole = stoken.nextToken();
					appDesc = stoken.nextToken();
					appFont = stoken.nextToken();
					if("Y".equals(appFont))
						out.println("<Font color=blue><B><Blink>"+appDesc+"</Blink></B></Font><BR>");
					else
						out.println(appDesc+"<BR>");
				}		
			}
%>
		&nbsp;</Font></Td>
		</Tr>
		<Tr align="left">
		<Th width='40%' valign='top'><Font size=<%=fontSize%>>Final Approver</Font></Th>
		<Td><Font size=<%=fontSize%>><%=finalApprover%>&nbsp;</Font></Td>
		</Tr>
<%	
	}
%>
		</Table>
		</Div>
<%
	}
	else if(!"0".equals(collectiveRfqNo) && wfCount == 0)
	{
%>	
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">
		<Tr align="center">
			<Th><Font size=<%=fontSize%>>QCF with Collective RFQ No <%=collectiveRfqNo%> has been created and waiting for approval</Font></Th>
		</Tr>
		</Table>
<%		
	}
	else
	{
%>
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">
		<Tr align="center">
			<Th><Font size=<%=fontSize%>>No Information is available about the QCF with Collective RFQ No : <%=collectiveRfqNo%></Font></Th>
		</Tr>
		</Table>
<%
	}
%>
</form>
</body>
</html>
