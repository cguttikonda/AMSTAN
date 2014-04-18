<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListTobeDelivered.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
var tabHeadWidth=95
var tabHeight="57%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>

<%
      Date today = new Date();
%>
	<script>

	function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,flag)
	{
		document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&flag="+flag;
	}

	function chkDates()
	{
		var fd = document.myForm.fromDate.value;
		var td = document.myForm.toDate.value;
	
		var curDate = new Date('<%=today.getYear()+1900%>',parseInt('<%=today.getMonth()%>',10),'<%=today.getDate()%>')
		if(fd=="")
		{
			alert("Please Enter From Date");
			return false;
		}
		
		if(td=="")
		{
			alert("Please Enter To Date");
			return false;
		}

		fd = ConvertDate(fd,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
		td = ConvertDate(td,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

		fd1 = new Date();
		td1 = new Date();
		a = fd.split(".");
		fd1 = new Date(a[2],(a[1]-1),a[0])
		b = td.split(".");
		td1 = new Date(b[2],(b[1]-1),b[0])

		if(fd1 < curDate)
		{
			alert("From Date should be greater than current date");
			document.myForm.fromDate.focus();
			return false;

		}

		if(fd1 > td1)
		{
			alert("From Date should be less than To Date");
			document.myForm.fromDate.focus();
			return false;
		}	
		return true;
	}

	function ezSubmit()
	{
		y=chkDates();
		if(y)
		{
			document.myForm.action="ezListToBeDelivered.jsp";
			document.myForm.submit();
		}
	}
	</script>
</head>

<body onLoad = "scrollInit()"  onResize="scrollInit()" scroll="no">
<form  method="post" name="myForm">
	<TABLE align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr>
	<td class="displayheader" width="50%" align="center">To Be Delivered Materials</th>
	</tr>
	</table>
	<br>

	<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr>
		<Th>From Date</Th>
		<td><input type=text name="fromDate" value="<%=fromDate%>"  readonly size=12 maxlength="10" class="InputBox"><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.myForm.fromDate",50,250,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")></td>
		<Th>To Date</Th>
		<td><input type=text name="toDate" value="<%=toDate%>"  readonly size=12 maxlength="10" class="InputBox"><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.myForm.toDate",50,250,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")></td>
		<td class="blankcell"><img  src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" onClick="ezSubmit()" border="none" style="cursor:hand"></td>
	</tr>
	</table>
<%
if (Count > 0)
{
%>


	<DIV id="theads">
	<Table id="tabHead" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<Tr>
	<th width="12%">PO No</th>    
      <th width="7%">Line</th>
      <th width="15%">Material</th>
      <th width="20%">Description</th>
      <th width="6%">UOM</th>
      <th width="11%">Qty</th>
      <th width="18%">Delivery <br>Date</th>
      <th width="18%">Commited Date</th>
      </Tr>
	</Table>
	</DIV>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:57%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
	<%

	boolean isAvailable=false;	
	for (int i=0 ; i < Count ; i++){
		Date DelDate = (Date)hdrXML.getFieldValue(i, "DELIVERYDATE");
		if (DelDate!=null&&DelDate.before(ToDate))
		{
	%>
		<Tr>
		<td width="12%"><A href="JavaScript:funLinkOpen('ezPoLineitems.jsp','<%=hdrXML.getFieldValueString(i,"ORDER")%>','<%=hdrXML.getFieldValueString(i,"NETAMOUNT")%>','<%=hdrXML.getFieldValueString(i,"CURRENCY")%>','Y')"  onMouseover="window.status='Click to view the PurchaseOrder Lines '; return true" onMouseout="window.status=' '; return true"><%=(hdrXML.getFieldValueString(i,"ORDER"))%></a></td>
		<td width="7%">
		<%
			try{
				out.println(Long.parseLong(hdrXML.getFieldValueString(i, "LINEOFBUSINESS")));
			}catch(Exception e){
				out.println(hdrXML.getFieldValueString(i, "LINEOFBUSINESS"));
			}

		%></td>
		<td width="15%">&nbsp;
		<%
			String matNo =hdrXML.getFieldValueString(i,"SUPPLIERTEXT");
			try{
				out.println(Long.parseLong(matNo));
			}catch(Exception e){
				out.println(matNo);
			}
		%></td>
		<td width="20%">&nbsp;<%=hdrXML.getFieldValueString(i,"VENDOR_NAME")%></td> 	
		<td width="6%">&nbsp;<%=hdrXML.getFieldValueString(i, "PAYMENTTERMSID")%></td>
		<td width="11%" align="right">&nbsp;
		<%
		double qty =Double.parseDouble(hdrXML.getFieldValueString(i, "NETAMOUNT"));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		out.println(nf.format(qty));
		%></td>
      		<td width="18%" align="center"><%=FormatDate.getStringFromDate((Date)hdrXML.getFieldValue(i, "DELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
	        <td width="18%" align="center"><%=FormatDate.getStringFromDate((Date)hdrXML.getFieldValue(i, "CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
		</Tr>
	<%	
 		  isAvailable=true;	
		}
		
	}

	if(!isAvailable)
	{

	%>
		<tr>
	        <td width="12%" align="center" colspan="7">No Deliveries Exist with in the selected Period.</td>
		</Tr>
	<%	
	}

	%>
	</Table>
	</Div>
<%}
else if ("".equals(fromDate)){
%>
	<br><br><br><br>
	<Table align="center" >
	<Tr><Td align="center" class="displayalert">
		Please select From Date,To Date to view the List of To be Delivered Materials between the selected period.	</Td></Tr></Table>
<%
}
else{
	%>
	<br><br><br><br>
	<Table align="center" >
	<Tr><Td align="center" class="displayalert">
		No Deliveries Exist with in the selected Period.
	</Td></Tr></Table>
	<%
}%>	
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
