<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iShowQcfStatus.jsp"%>
<html>
<head>
<Title>Approval Hierarchy</Title> 
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="70%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm">
<%
	if(wfCount > 0)
	{
%>
		<div align=center style="position:absolute;top:10%;visibility:visible;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="80%">
		
		<Tr>
			<Th colspan=2 align="center">Status of <%=docDesc%> : <%=collectiveRfqNo%></Th>
		</Tr>
<%
	if(!("CEO".equals(sessionRole) || "CFO".equals(sessionRole)))
	{
%>		
		<Tr align="left">
			<Th width='40%'>Initiator</Th>
			<Td><%=getUserName(Session,createdBy,"U",(String)session.getValue("SYSKEY"))%></Td>
		</Tr>

<%
	}
%>
		<Tr align="left">
			<Th width='40%'>Current Status</Th>
			<Td><%=currentStatus%></Td>
		</Tr>
<%
	if(!("CEO".equals(sessionRole) || "CFO".equals(sessionRole)))
	{
%>
		<Tr align="left">
		<Th width='35%' valign='top' colspan=2><Font size=2>Work Flow Hierarchy</Font></Th>
		</Tr>
		<Tr>
		<Td colspan=2><Font size=2>
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
		&nbsp;</Td>
		</Tr>
		<Tr align="left">
		<Th width='40%' valign='top'>Final Approver</Th>
		<Td><%=finalApprover%>&nbsp;</Td>
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
		<div align=center style="position:absolute;top:10%;visibility:visible;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
		<Tr align="center">
			<Th><%=docDesc%> <%=collectiveRfqNo%> has been created and waiting for approval</Th>
		</Tr>
		</Table>
		</div>	
<%		
	}
	else
	{
%>
		<div align=center style="position:absolute;top:10%;visibility:visible;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
		<Tr align="center">
			<Th>No Information is available about the <%=docDesc%> : <%=collectiveRfqNo%></Th>
		</Tr>
		</Table>
		</div>
<%
	}
%>

<div id="EzButtonDiv" align=center style="position:absolute;top:80%;visibility:visible;width:100%">
<Table>
<Tr>
	<Td  class="TDCommandBarBorder">
      <table border="0" cellspacing="3" cellpadding="5">
	    <tr>
          <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:window.close()">
                <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
          </td>
	    </tr>
	    </table>
	</Td>
</Tr>
</Table>
</div>

</form>
</body>
</html>
