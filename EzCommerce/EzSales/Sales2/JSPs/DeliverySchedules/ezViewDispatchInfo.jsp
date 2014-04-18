<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iViewDispatchInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iViewDispatchInfo_Lables.jsp"%>
<%@ page import ="ezc.ezutil.FormatDate" %>
<html>
<head> 
<title>view Dispatch Info</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
			  var tabHeadWidth=95
	 	   	  var tabHeight="60%"
		</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	function displayDetails(aa,slto)
	{	
		document.forms[0].action="ezViewReceivedDel.jsp?DeliveryNo="+aa+"&SalesOrder="+<%=sonum%>
		document.forms[0].submit();
	}
	function ezBack(){
		document.forms[0].action="ezViewOrders.jsp";
		document.forms[0].submit();
	}
	</script>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form   method="post" name="DispatchInfo" onSubmit="return false">
	<input type="hidden" name="Stat" value="<%=St%>" >
	<input type="hidden" name="from" value="ezViewDispatchInfo" >
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
   <td height="35" class="displayheaderback" align=center width="100%">
    <%
    		if ("R".equals(St)){
    %>
    			<%=preDispList_L %>
    <%
    		}else if ("D".equals(St)){
    %>
    				<%=newDispList_L%>
    <%
    		}
     %>
    </td>
</tr>
</table>	

<%
	
	FormatDate fd=new FormatDate();
	
	int rListCount = retList.getRowCount();

	if((retList!=null)&&(rListCount>0))
	{
%>
		<Div id="theads">
		<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	
		<Tr>
		<Th width='15%'>Delvery No</Th>
		<Th width='15%'>Doc No</Th>
		<Th width='13%'>Doc Date</Th>
		<Th width='17%'>Shipment Date</Th>
		<Th width='25%'>Carrier Name</Th>
		<Th width='15%'>Status</Th>
		</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
		<Table align=center  id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%	
		for (int i=0;i<rListCount;i++)
		{
			String stat=null;
			String s=retList.getFieldValueString(i,"STATUS");
			if ("N".equals(s)) stat="New";
			else if("D".equals(s)) stat="Dispatched";
			else if ("R".equals(s)) stat="Acknowledged";

			if (("D".equals(s))||("R".equals(s)))
			{
			%>
				<Tr>
				<Td width='15%'><a href='JavaScript:displayDetails("<%=retList.getFieldValue(i,"DELIVERYNO")%>")'><%=retList.getFieldValue(i,"DELIVERYNO")%></a></Td>	
				<Td width='15%'><%=retList.getFieldValue(i,"DC_NR")%></Td>
				<Td width='13%' align="center"><%=fd.getStringFromDate((Date)retList.getFieldValue(i,"DC_DATE"),".",FormatDate.DDMMYYYY)%></Td>
				<Td width='17%' align="center"><%=fd.getStringFromDate((Date)retList.getFieldValue(i,"SHIPMENT_DATE"),".",FormatDate.DDMMYYYY)%></Td>
				<Td width='25%'><%=retList.getFieldValue(i,"CARRIER")%></Td>
				<Td width='15%'><%=stat%></Td>
				</Tr>
			<%}
		}
		%>
		</Table>
		</div>
	<%}
	else
	{%>
		<br><br><br><br><table  align=center border=0 >
		<tr>
		<Td class=displayalert align="center">
			<% if ("R".equals(Stat)){%>
				<%=noPreDispList_L%>.
			<%}else if ("D".equals(Stat)){%>
				<%=noNewDisp_L%>.
			<%}%>
		</Td>
	<%
	}%>
	
<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("ezBack()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
