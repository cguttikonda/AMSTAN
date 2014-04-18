<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%
	
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	
	String display_header = "Frequently Asked Questions";
%>
<html>
<head>
<title>FAQs</title>
<script>
	function funOpen(obj,obj1)
	{
		newWindow = window.open(obj,"Mywin"+obj1,"resizable=yes,left=20,top=10,height=600,width=850,status=no,toolbar=no,menubar=no,location=no")
	}
	var tabHeadWidth=100
	var tabHeight="65%"
	
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<style>
td.pagestyle {
	
    	background-color: #ffffff
    	
}
td.faqdata{
	background-color: #ffffff
}
table
{
	background-color: #ffffff
}

</style>

</head>

<%--<body onContextMenu="return true" scroll=yes onLoad="scrollInit();" onResize="scrollInit()">--%>

<body background="../../../../EzCommon/Images/Body/NOTEBOOK.JPG" onContextMenu="return true" scroll=no onLoad="scrollInit()" onResize="scrollInit()">


<Div id="faqDiv" style="overflow:auto;position:absolute;width:100%;height:100%">
<TABLE id="faqTab" border=0 cellPadding=0 bgcolor="#FOFODD" cellSpacing=0 style="width=90%" align="center">
<TBODY>
<TR> <a name="top"></a><td><%@ include file="ezDisplayHeader.jsp"%></td></TR>
<TR >
	
	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFAQs.jsp#one">
			<img src="../../Images/FAQs/question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How do I view Purchase Orders ?<br></font>
		</a>
	</td>
</tr>
<TR>
	<a href = "ezFAQs.jsp#three">
	<TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#three"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I View Shipment details ?<br></font></a></td></tr>

<%
	String userType = (String)session.getValue("UserType");
	if(!userType.equals("2"))
	{
	
%>

	
<TR><a href = "ezFAQs.jsp#four"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#four"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I Add Shipment details ?<br></font></a></td></tr>

<TR><a href = "ezFAQs.jsp#five"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#five"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I track status of shipments made by me ?<br></font></a></td></tr>

<%

 }
 
 %>

<TR><a href = "ezFAQs.jsp#six"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#six"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I view Invoice details ?<br></font></a></td></tr>

<TR><a href = "ezFAQs.jsp#seven"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#seven"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I view Invoice Payment Details ?<br></font></a></td></tr>

<TR><a href = "ezFAQs.jsp#eight"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#eight"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I view my Account Statement ? <br></font></a></td></tr>

<TR><a href = "ezFAQs.jsp#nine"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#nine"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I view the Outstanding Balance ?<br></font></a></td></tr>

<TR><a href = "ezFAQs.jsp#ten"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#ten"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I communicate with the buyer at Enterprise ?</font></a></td></tr>

<TR><a href = "ezFAQs.jsp#eleven"><TD width="100%" style="align:center" class="pagestyle">
&nbsp;&nbsp;&nbsp;&nbsp;
<a href = "ezFAQs.jsp#eleven"><img src="../../Images/FAQs/question.gif" style="border:0"><font size=2 style="color:blue;">How do I inform Enterprise about changes in my Address ?<br></font></a></td></tr>


		<TR>
			<TD class="pagestyle">
			<TD width="50%" style="align:center" class="pagestyle">
			<br><br><br><br>
			</TD>
			</TD>
		</TR>
</Table>

			<TABLE id="InnerBox1Tab" border=0 cellPadding=0 cellSpacing=2 width="90.5%" align="center">
				<TBODY>
		<TR>
		<TD width="100%" class="pagestyle"><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="one"><b>How do I view Purchase Orders ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		The Purchase Orders can be viewed by their status;  To Be Acknowledged ,Acknowledged,Closed and All.
		To Be Acknowledged status shows you the Order that are Released by the Matrix Laboratories and Supplier needs to acknowledge by entering the Delivery Schedules Committed Dates.
		Acknowledged status shows you the Orders for which deliveries have not been completed as per the Matrix Laboratories Requirement.
		Closed status shows you the Orders for which deliveries have been completed.
		All status shows you all the above Orders.<i>
		New Purchase Orders since your last login, are displayed on your Start page.</i>
		Clicking on the hyperlink takes you to the new list.</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Purchase Orders';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour10.html","PODetails")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="three"><b>How do I View Shipment details ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		You can view shipment details through;  Order Details, View Shipments, Search Option.
		The purchase order details and the schedule agreement details screen has a button in the bottom to view shipments associated with those orders.
		The View Shipment option in the Shipments menu allows you to choose a specific purchase order or schedule agreement for which you would like to see the shipment details.
		The Search by Delivery Challan option in the Search menu allows to enter the Delivery Challan number and monitor the status of your shipment.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Shipment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour31.html","ViewPoAcknowledgement")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		
		&nbsp;&nbsp;&nbsp;&nbsp;
		
<%
			userType = (String)session.getValue("UserType");
			if(!userType.equals("2"))
			{
			
%>
		
		
		<font class="faqheader"><font size=2><a name="four"><b>How do I Add Shipment details ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		You can add shipment details through;  Order Details, Add Shipments.
		The purchase order details and the schedule agreement details screen has a button in the bottom to add shipment details associated with those orders.
		The Add Shipment option in the Shipments menu allows you to choose a specific purchase order or schedule agreement for which you would like to add the shipment details.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='Add Shipment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour61.html","AddPoAcknowledgement")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="five"><b>How do I track status of shipments made by me ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		You can track the status of your shipments through: Order Details, View Shipments, Search.
		The Purchase Order and Schedule Agreement details screen has a button "View Receipts" on the bottom. This takes you to the list of Receipts screen associated with the order. You can see the status of each receipt in the column. You can also see the reasons for rejection, if any, by clicking on the rejected quantity.
		The View Shipments option in the Shipments menu allows you to choose the order for which shipment you are trying to track.
		The Delivery Challan option in the Search menu allows you to enter your Delivery Challan number to track the status of your shipment.  This is the fastest way to track the status.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='Track Status of Shipments';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour41.html","PoReceipts")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
<%		
		}		
%>		
		<font class="faqheader"><font size=2><a name="six"><b>How do I view Invoice details ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		You can view the Invoice details through: Invoices, Order Payment Details & Search
		The Invoices menu offers you the choices of browsing through open and closed status invoices. You can view the details by clicking on the SAP invoice number in the list. The Vendor Invoice number in the list is the number on the invoice provided by you.
		You can also view invoice details by clicking on the 'Payments Details' button in the order details of both Purchase Order and Schedule Agreements.
		You can use the search option directly go the invoice details by providing your invoice number or the SAP invoice number. You can also search for invoices associated with a particular purchase order and drill down to details.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Invoice Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour50.html","InvoiceDetails")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="seven"><b>How do I view Invoice Payment Details ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		You can view the payment status of any invoice by selecting the invoice details as per above and clicking on the Payment Details button. If the payment has been made, the check number, date and bank on which the check was drawn is displayed.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Invoice Payment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour53.html","InvoicePaymentDetails")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="eight"><b>How do I view my Account Statement ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		From the Self Service menu, choose the A/c Statement option. You have to select the period for which Statement you would like to view.  To faster response from the system, keep your selection as brief as possible.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Account Statement';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss02.html","AcStatement")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="nine"><b>How do I view the Outstanding Balance ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		From the Self Service menu, choose the Outstanding Balance option.  You will see the balance due to you from Enterprise.  Clicking on the balance amount gives you a list of the open invoices. Click on the invoice number to view details. Click on the Payment Details button to view the payment details.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='View Outstanding Balance';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss01.html","OutStandingBalance")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="ten"><b>How do I communicate with the buyer at Enterprise ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		Apart from the conventional methods of telephone and fax, you can now communicate with the buyer at Enterprise efficiently via the mail feature in this portal.
		</font></td></tr>
		
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='Know how to communicate with Enterprise';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss06.html","mailing")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		
		</tr>
		</table>
		<br><br>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><font size=2><a name="eleven"><b>How do I inform Enterprise about changes in my Address ?</b></a></font></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata"><font size=2>
		Use the Change Address option in the Self Service menu to enter details of your new address and press the submit button.  This new information is updated in Enterprise records.
		</font></td></tr>
		<tr>
		<td class="pagestyle"><a href="javascript:void(0)" onMouseOver="window.status='Know how to update Enterprise about your change of address';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss04.html","ChangeAddress")>Take A Tour</a></td>
		<td align="right" class="pagestyle"><a href="ezFAQs.jsp#top"><img border =0 src = "../../Images/Others/go_up_arrow.png"></a></td>
		</tr>
		</table>

<br><br>

		<br><br>


<br>

</td>
</tr>
</tbody>
</table>
</Div>
<Div id="MenuSol">
</Div>	
</body>
</html>
