<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezparam.*" %>

<%
	String collRfq = request.getParameter("QcfNumber");
	
	ezc.ezworkflow.client.EzWorkFlowManager manager = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezworkflow.params.EziWFDocHistoryParams params = new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setDocId(collRfq);
	params.setGraphNo("A");
	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)manager.getWFDocHistory(mainParams);

	int rowCount = ret.getRowCount();
%>

<html>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<%
	String display_header = "";
	if(rowCount == 0)
	{
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		<br><br><br>
		<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th>No Information Found.</th>
		</tr>
		</table>
	
<%
	}
	else
	{
		display_header = "Report";
%>

		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		
		<DIV id="theads">
		<table  id="tabHead" width="67%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	  	<tr align="center" valign="middle">
		<th width="50%">User</th>
		<th width="50%">Action</th>
	  	</tr>
		</Table>
		</DIV>
	
	
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="70%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
		String comments = null;
		for(int i=0;i<rowCount;i++)
		{
			comments = ret.getFieldValueString(i,"EWDHD_COMMENTS");
%>
			<Tr>
<%
			    if("E".equals(comments))
			    {
%>
				<Td width="50%">-</Td>
				<Td width="50%">ESCALATED</Td>
<%
			    }
			    else
			    {
%>
				<Td width="50%"><%=ret.getFieldValueString(i,"EWDHD_ACTION_BY")%></Td>
				<Td width="50%"><%=ret.getFieldValueString(i,"EWDHD_WF_STATUS")%></Td>
<%
			     }	
%>
			</Tr>
<%
		}
%>
		</Table>
		</Div>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
<body>
</html>
