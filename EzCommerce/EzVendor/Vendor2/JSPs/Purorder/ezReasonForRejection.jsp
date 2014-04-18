<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iReasonForRejection_Labels.jsp"%>
<%
	String Reason=request.getParameter("Reason");
	String order=request.getParameter("order");
	String line=request.getParameter("line");
	String orderDate= request.getParameter("OrderDate");
	String netOrderAmount = request.getParameter("OrderValue");
	String orderCurrency = request.getParameter("orderCurrency");

%>
<html>
<head>
<title>Reason For Rejection </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<!-- <TABLE width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr align="center"> 
    	<td class="displayheader" align=center>Reasons For Rejection </td>
	</tr>	
	<Table> -->
	<% String display_header=reaForReject_L;%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>

	
	<br><br>
<% if(!("".equals(Reason))) {%>
	<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr><td class="blankcell" align=center> 
	<font color="blue" ><%=theFolReas_L%></font>
	</td></tr></Table><br>
	<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr><th align="center"><%=reas_L%></th></tr>
    	<tr><td align='center'><%=Reason%></td></tr>
	</table>
<%}else{
%>
	<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr> 
	<td align=center><b><%=resNotEntered_L%><b></td>
     	</tr></table>
<%}%>	
	<br><br><br>
	<!-- <Table align='center'><Tr><Td class="blankcell"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" onClick="history.go(-1)"></Td></Tr></Table> -->
	<Div id="ButtonDiv" style="position:absolute;top:90%;left:45%;visibility:visible">
	<Center>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		
		out.println(getButtonStr(buttonName,buttonMethod));	
	%>
</Center>
</div>
<Div id="MenuSol"></Div>
</body>
</html>
