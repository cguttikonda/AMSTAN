<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezcommon.*,java.util.*,java.util.*,ezc.ezparam.*,ezc.ezshipment.params.*,java.text.*" %>
<jsp:useBean id="shipManager" class="ezc.ezshipment.client.EzShipmentManager" />

<%
	int Count = finalret.getRowCount();
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=90
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script>
	function funDetails(ind,status)
	{
		shid=''
		stat=''
		if(isNaN(document.myForm.status.length))
		{
			stat = document.myForm.status.value;
			shid = document.myForm.shipid.value;
		}
		else
		{
			stat = document.myForm.status[ind].value;
			shid = document.myForm.shipid[ind].value;
		}
		if(status=='N')
		{
			document.myForm.action="ezShipmentDetails.jsp?ShipId="+shid+"&Status="+stat;
			document.myForm.submit();
		}
		else if(status=='Y')
		{
			document.myForm.action="ezViewShipmentDetails.jsp?ShipId="+shid+"&Status="+stat;
			document.myForm.submit();
		}
	}
	function funReceipts(dc){
		document.myForm.action="ezShipPOReceiptDetails.jsp?DCNo="+dc
		document.myForm.submit();
	}
	function submitIt()
	{
		if (document.myForm.base.selectedIndex==0)
		{
			alert ("Please select Document Type.");
			document.myForm.base.focus();
			return false;
		}
		else{
			//document.myForm.action = "ezListViewShipmentHeaders.jsp";
			document.myForm.showData.value='Y'
			document.myForm.submit()
		}
	}	
	</script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type="hidden" name="ponum" value="<%=ponum%>" >
<input type="hidden" value="<%= ponum %>" name="baseValue">
<input type="hidden" value="<%= base %>" name="base">
<input type="hidden" value="<%= OrderValue %>" name="OrderValue">
<input type="hidden" value="<%= orderCurrency%>" name="orderCurrency">
<input type="hidden" value="<%= currency%>" name="currency">
<%
		String display_header = "View Shipments Details";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<br>
		<%@ include file="ezSelectViewShipment.jsp" %>
<%
		if(showData)
		{
%>		
			<%@ include file="../../../Includes/JSPs/Shipment/iListViewShipmentHeader.jsp" %>
			if (Count > 0)
			{
%>		
				<DIV id="theads">
				<TABLE id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
				<tr>
					<th width="20%">DN No</th>
					<th width="20%">DN Date </th>
					<th width="20%">Invoice No</th>
					<th width="20%">Shipment Date </th>
					<th width="20%">Details</th>
				</tr>
				</Table>
				</DIV>

				<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
				<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
				for(int i=0;i< Count;i++)
				{
					Date dcdate=(Date)finalret.getFieldValue(i,"DC_DATE");
					Date shipdate=(Date)finalret.getFieldValue(i,"SHIPMENT_DATE");
					ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();

					String Status=finalret.getFieldValueString(i,"STATUS");	// Saved or Submitted
%>
					<tr align="center">
					<td width="20%" align="left">
<% 
					if ((Status!=null)&&("N".equalsIgnoreCase(Status)))
					{
%>
						<%=finalret.getFieldValueString(i,"DC_NR")%>
<%			
					}
					else
					{
%>
						<%=finalret.getFieldValueString(i,"DC_NR")%>
<%
					}
%>
					</td>
					<td align="center" width="20%"><%=fd.getStringFromDate(dcdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
					<td width="20%" align="left">
<%
					if (finalret.getFieldValue(i,"INV_NUM")!=null && !finalret.getFieldValueString(i,"INV_NUM").equals(""))
						out.println(finalret.getFieldValueString(i,"INV_NUM"));
					else	
						out.println("&nbsp;");
%>
					</td>
					<td width="20%" align="center"> <%=fd.getStringFromDate(shipdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%> </td>
					<td width="20%" align="center">
					<input type="hidden" name="status" value="<%=finalret.getFieldValueString(i,"STATUS")%>" >
					<input type="hidden" name="shipid" value="<%=finalret.getFieldValueString(i,"SH_ID")%>" >
					<a href="JavaScript:funDetails(<%=i%>,'<%=finalret.getFieldValueString(i,"STATUS")%>')"  onMouseover="window.status='Click to view the Shipment Details '; return true" onMouseout="window.status=' '; return true">click</a></td>
					</tr>
<%
				}
%>
				</table>
				<br><br>
				</div>
<%
			}
			else
			{
				String noDataStatement = "<CENTER>For Purchase Order No : ";
				noDataStatement += ponum+"<BR><BR>No Shipment Info added by "+(String)session.getValue("Vendor")+"</CENTER>";
%>
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
			}
		}
		else
		{
			String noDataStatement = "No Shipment Info added by "+(String)session.getValue("Vendor")+".";
%>
			<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
		}
%>
	
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
