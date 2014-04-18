<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@page import="ezc.ezutil.*,java.util.*"%>
<%@include file="../../../Includes/Jsps/Rfq/iOfflineListRFQs.jsp"%>
<html>
<head>
<Script>
	var tabHeadWidth=70
	var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>	<title>List of RFqs</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	function viewDetails(orderNo,closeDate)
	{
		document.myForm.PurchaseOrder.value = orderNo
		document.myForm.EndDate.value = closeDate
		document.myForm.action = "ezOfflineViewRFQDetails.jsp"
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
</Script>
</head>

<body  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type="hidden" name="PurchaseOrder">
<input type="hidden" name="EndDate">
<input type="hidden" name="OrderDate">
<input type="hidden" name="type" value="<%=type%>">
<%
	String display_header = "";
	java.util.Hashtable rfqSysHash=new java.util.Hashtable();
	
	if(RetrfqCount>0)
     	{
     		
		if(type.equals("New"))
		{
			display_header = "List of New RFQs";
		}
		else
		{
			display_header = "List of RFQs";
		}
		display_header += " For "+(String)session.getValue("Vendor");
		
		
		
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<br>
		<Div id="theads">
		<table id="tabHead" width="70%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<tr align="center" valign="middle">
				<th width="34%">RFQ No</th>
 				<th width="33%">RFQ Date</th>
 				<th width="33%">RFQ Closing Date</th>
 			</tr>
		</table>
		</Div>

		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:60%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
   		FormatDate fd = new FormatDate();
   		
   		for(int i=0;i<RetrfqCount;i++)
   		{	
			String orderNo = myRetrfq.getFieldValueString(i,"RFQ_NO");
			String mysys = myRetrfq.getFieldValueString(i,"SYS_KEY");
			
			rfqSysHash.put(orderNo,mysys);
			
			String closeDate ="";
			String orderDate ="";
			String clDate = fd.getStringFromDate((Date)myRetrfq.getFieldValue(i,"VALID_UPTO"),".",fd.DDMMYYYY);
			closeDate = clDate;
			orderDate = fd.getStringFromDate((Date)myRetrfq.getFieldValue(i,"RFQ_DATE"),".",fd.DDMMYYYY); 
			
			
			
%>
    			<tr>
		      	<td width="34%" align="center">
<%			if("List".equalsIgnoreCase(type))
			{
%>
				<a href="JavaScript:viewQuoteDetails('<%=orderNo%>','<%=clDate%>','<%=orderDate%>')"><%=orderNo%></a> 
				</td>
<%			}
			else
			{
%>
      				<A HREF ="JavaScript:viewDetails('<%=orderNo%>','<%=clDate%>')"  onMouseover="window.status='Click to view the RFQ Lines '; return true" onMouseout="window.status=' '; return true"><%=orderNo%></a> 
      				</td>
<%			}
%>
      			<td align="center" width="33%"><%=orderDate%>&nbsp;</td>
      			<td align="center" width="33%">&nbsp;
      				<%=closeDate%>
      			</td>
    			</tr>
<%		}	
%>
  		</table>
		</div>
<%	}
   	else
   	{
%>	
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<tr align="center">
<%		if(type.equals("New"))
		{
%>
			<th>No New RFQs Exist.</th>
<%		}
		else
		{
%>
			<th>No RFQs Exist.</th>
<%		}
%>
		</tr>
		</table>
<%
	}
	session.putValue("RFQSYSHASH",rfqSysHash);
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
