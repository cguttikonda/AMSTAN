<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Purorder/iGetContractsList.jsp"%> 
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example" scroll=no>
<%
	String display_header	= "Contracts";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<div id="container">
	<div id="demo">
	<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
	<thead>
		<tr>
			<th>Agreement</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>

<%
			for(int i=0;i<myRetCount;i++)
			{		
				String poNum		= ret.getFieldValueString(i,"ORDER");
				String contractNum 	= Long.parseLong(ret.getFieldValueString(i,"ORDER"))+"";
				String agreeDate   	= formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>		
		<tr>
			<td align="center"><a href="../RFQ/ezGetAgrmtDetails.jsp?agmtNo=<%=poNum%>&viewType=VIEW"><%=contractNum%></a></td>
			<td align="center"><%=agreeDate%></td>
		</tr>
<%
			}
%>
	</tbody>
	</table>
</div>
<div class="spacer"></div>
</div>
<Div id="MenuSol"></Div>
</body>
</html>