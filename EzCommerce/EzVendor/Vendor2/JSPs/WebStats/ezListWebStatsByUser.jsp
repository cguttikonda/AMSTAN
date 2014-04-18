<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/WebStats/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iActiveUserList_Labels.jsp"%>

<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= "";
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	if(fd != null && td != null)
	{
	}
	else
	{
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		tomorrow.setDate(today.getDate()+1);
		ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
		format.getStringFromDate(today,".",ezc.ezutil.FormatDate.DDMMYYYY);
		format.getStringFromDate(tomorrow,".",ezc.ezutil.FormatDate.DDMMYYYY);
	}		
	if(fromDate==null || fromDate.equals("null") )
		fromDate="";
	if(toDate==null || toDate.equals("null") )
		toDate="";
	String loginDate = "";
	String logotDate = "";
	String loginTime = "";
	String logotTime = "";
	String loggedIn="";
	String loggedOut="";
	String ipAddress = "";
%>
<html>
<head>
	<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
	var tabHeadWidth=90
	var tabHeight="40%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<BODY  onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')">
<form name=myForm>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<input type="hidden" name="chkdindex">
<input type=hidden name="fromDate" value="<%=fromDate%>">
<input type=hidden name="toDate"   value="<%=toDate%>">

<%
	String display_header = "";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%@ include file="../../../Includes/Jsps/WebStats/iListWebStats.jsp"%>
<%
	if(retWebStats.getRowCount()==0)
	{
%>			<br><br><br>
			<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th><%=noUserYet_L%></Th>
			</Tr>
			</Table>

<%
	}
	else
	{
%>
		<DIV id="theads">
		<table   id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="13%" align=center rowspan=2><%=userId_L%></Th>
			<Th width="19%" align=center  rowspan=2><%=userName_L%></Th>
			<Th width="17%" align=center  rowspan=2><%=IP_L%></Th>
			<Th width="25%" align=center colspan=2><%=logIn_L%></Th>
			<Th width="26%" align=center colspan=2><%=logOut_L%></Th>
		</Tr>
		<Tr>
			<Th width="13%" align="center"><%=date_L%></Th>
			<Th width="12%" align="center"><%=time_L%></Th>
			<Th width="13%" align="center"><%=date_L%></Th>
			<Th width="13%" align="center"><%=time_L%></Th>
		</Tr>
		</table>
		</DIV>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab"  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
			for(int i=0;i<retWebStats.getRowCount();i++)
			{
				loggedIn	=retWebStats.getFieldValueString(i,"LOGGED_IN");
				loggedOut	=retWebStats.getFieldValueString(i,"LOGGED_OUT");
				loggedOut	=(loggedOut==null)||"null".equals(loggedOut)?"&nbsp;       &nbsp;":loggedOut;
				loginDate = loggedIn.substring(0,10);
				loginTime = loggedIn.substring(11,19);
				if(!loggedIn.equals(loggedOut))
				{
					logotDate = loggedOut.substring(0,10);
					logotTime = loggedOut.substring(11,19);
				}
				else
				{
					logotDate = "";
					logotTime = "";
				}
				if("null".equals(retWebStats.getFieldValue(i,"IP")))
					ipAddress = "&nbsp;";
				else
					ipAddress = retWebStats.getFieldValue(i,"IP")+"&nbsp;";
					
		%>
				<Tr>
					<Td width="13%" align=left><%=retWebStats.getFieldValue(i,"USER_ID")%></Td>
					<Td width="19%" align=left><%=retWebStats.getFieldValue(i,"NAME")%></Td>
					<Td  width="17%" align=center><%=ipAddress%></Td>
					<Td  width="13%" align=center><%=loginDate%>&nbsp;</Td>
					<Td  width="12%" align=center><%=loginTime%>&nbsp;</Td>
					<Td  width="13%" align=center><%=logotDate%>&nbsp;</Td>
					<Td  width="13%" align=center><%=logotTime%>&nbsp;</Td>
				</Tr>
		<%
			}
		%>
			</table>
			</div>
			<div id='showTot' align='center' STYLE='Position:Absolute;left:10%;width:78%;height:10%;top:87%'>
			<Table align=right width=30% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th width="60%"><%=totalUsers_L %></Th>
				<Td width="40%" align=right><%=retWebStats.getRowCount()%></Td>
			</Tr>
			</Table>
			</div>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
