<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQs.jsp"%>
<%@page import="ezc.ezutil.*"%>
<Html>
<Head>
<Script>
var tabHeadWidth=70
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>	<title>List of RFqs</title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

	<script>
	function viewDetails(orderNo,closeDate)
	{
		document.myForm.PurchaseOrder.value = orderNo
		document.myForm.EndDate.value = closeDate
		document.myForm.action = "ezViewRFQDetails.jsp"
	 	document.myForm.submit()
	}
	function viewQuoteDetails(orderNo,closeDate,orderDate)
	{
		document.myForm.PurchaseOrder.value = orderNo
		document.myForm.EndDate.value = closeDate
		document.myForm.OrderDate.value = orderDate
		document.myForm.action = "ezViewQuoteDetails.jsp"
	 	document.myForm.submit()
	}
	function goToPlantAddr(plant)
	{
		window.open("../Purorder/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=300,height=280");
	}
	</script>
</head>

<body  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">

	<input type="hidden" name="PurchaseOrder">
	<input type="hidden" name="EndDate">
	<input type="hidden" name="OrderDate">
	<input type="hidden" name="type" value="<%=type%>">
	<%
	if(Count>0)
     	{
	%>
		<TABLE width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
 		<tr align="center">
		<%if(type.equals("New")){%>
  		<td class="displayheader">List of New RFQs</td>
		<%}else{%>
  		<td class="displayheader">List of RFQs</td>
		<%}%>
  		</tr>
		</table>
		<br>

		<DIV id="theads">
		<table id="tabHead" width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr align="center" valign="middle">
		<th width="30%">RFQ No</th>
 		<th width="30%">RFQ Date</th>
 		<th width="30%">RFQ Closing Date</th>
 		<!--<th width="10%">Plant</th>-->
 		</tr>
		</table>
		</DIV>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<%
   		FormatDate fd = new FormatDate();
   		for(int i=0;i<Count;i++)
   		{
			String orderNo = hdrXML.getFieldValueString(i,"ORDER");
			String closeDate = fd.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),".",FormatDate.DDMMYYYY);
			String orderDate =fd.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		%>
    			<tr>
		      	<td width="30%" align="center">
			<%if ("List".equalsIgnoreCase(type)){%>
			<a href="JavaScript:viewQuoteDetails('<%=orderNo%>','<%=closeDate%>','<%=orderDate%>')">
			<%=orderNo%></a> </td>
			<%}else{%>
      			<A HREF ="JavaScript:viewDetails('<%=orderNo%>','<%=closeDate%>')"  onMouseover="window.status='Click to view the RFQ Lines '; return true" onMouseout="window.status=' '; return true">
			<%=orderNo%></a> </td>
			<%}%>
      			<td align="center" width="30%"><%=orderDate%></td>
      			<td align="center" width="30%"><%=fd.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
      			<!--<td align="center" width="10%"><a href="JavaScript:void(0)" onClick=goToPlantAddr('<%=hdrXML.getFieldValueString(i,"COMPCODE")%>')><%=hdrXML.getFieldValueString(i,"COMPCODE")%></a></td>-->
    			</tr>
		<%}
		%>
  		</table>
		</div>
<%	}
   	else
   	{
%>		<br><br><br><br>
		<table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align="center">
		<tr align="center">
		<%if(type.equals("New")){%>
			<th>No New RFQs Exist.</th>
		<%}else{%>
			<th>No RFQs Exist.</th>
		<%}%>
		</tr>
		</table>
	<%
	}%>
</form>
</body>
</html>
