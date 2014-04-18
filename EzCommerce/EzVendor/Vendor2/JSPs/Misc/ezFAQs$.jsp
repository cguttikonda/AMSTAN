<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>FAQs</title>
<script>
	function funOpen(obj,obj1)
	{
		newWindow = window.open(obj,"Mywin"+obj1,"left=20,top=10,height=500,width=750,status=no,toolbar=no,menubar=no,location=no")
	}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>

<body onContextMenu="return true" scroll=auto>
<% String display_header = "Frequently Asked Questions"; %>
<%@ include file="ezDisplayHeader.jsp"%>

<TABLE border=0 cellPadding=0 cellSpacing=2 width="100%">
<TR><td	><a href = "ezFAQs.jsp#one">
<TD width="100%"><br>&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#one">How do I view Purchase Orders ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#two">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#two">How do I view Schedule Agreements ?</a></font></td></tr>


<TR><td><a href = "ezFAQs.jsp#three">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#three">How do I View Shipment details ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#four">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#four">How do I Add Shipment details ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#five">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#five">How do I track status of shipments made by me ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#six">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#six">How do I view Invoice details ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#seven">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#seven">How do I view Invoice Payment Details ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#eight">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#eight">How do I view my Account Statement ?   </a></font></td></tr>


<TR><td><a href = "ezFAQs.jsp#nine">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#nine">How do I view the Outstanding Balance ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#ten">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#ten">How do I communicate with the buyer at Enterprise ?</a></font></td></tr>

<TR><td><a href = "ezFAQs.jsp#eleven">
<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a href = "ezFAQs.jsp#eleven">How do I inform Enterprise about changes in my Address ?</a></font></td></tr>

<%
	String userType = (String)session.getValue("UserType");
	if(!userType.equals("3"))
	{
%>
		<TR><td><a href = "ezFAQs.jsp#twelve">
		<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a href = "ezFAQs.jsp#twelve">How do I View and Submit New QCF ?</a></font></td></tr>


		<TR><td><a href = "ezFAQs.jsp#thirteen">
		<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a href = "ezFAQs.jsp#thirteen">How do I View status of the QCF ?</a></font></td></tr>

		<TR><td><a href = "ezFAQs.jsp#forteen">
		<TD width="100%">&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a href = "ezFAQs.jsp#forteen">How do I View Approved QCFs ?</a></font></td></tr>
<%
}
%>

		</Table>
		
		<TABLE border=0 cellPadding=0 cellSpacing=2 width="100%">
		<TBODY>
<TR>
<TD width="100%"><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="one">How do I view Purchase Orders ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
The Purchase Orders can be viewed by their status;  To Be Acknowledged ,Acknowledged,Closed and All.
To Be Acknowledged status shows you the Order that are Released by the Ranbaxy Laboratories and Supplier needs to acknowledge by entering the Delivery Schedules Committed Dates.
Acknowledged status shows you the Orders for which deliveries have not been completed as per the Ranbaxy Laboratories Requirement.
Closed status shows you the Orders for which deliveries have been completed.
All status shows you all the above Orders.<i>
New Purchase Orders since your last login, are displayed on your Start page.</i>
Clicking on the hyperlink takes you to the new list.</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Purchase Orders';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour10.html","PODetails")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="two">How do I view Schedule Agreements ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%>
<br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
The Schedule Agreements can be viewed by their status;  Open, Closed and All.
Open status shows you the Orders for which deliveries have not been completed as per Ranbaxy Laboratories Requirement.
Closed status shows you the Orders for which deliveries have been completed.
All status shows you both the above Orders.<i>New Schedule Agreements since your last login, are displayed on your Start page.</i> Clicking on the hyperlink takes you to the new list.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Schedule Agreements';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour20.html","SchAgmtStatus")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="three">How do I View Shipment details ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
You can view shipment details through;  Order Details, View Shipments, Search Option.
The purchase order details and the schedule agreement details screen has a button in the bottom to view shipments associated with those orders.
The View Shipment option in the Shipments menu allows you to choose a specific purchase order or schedule agreement for which you would like to see the shipment details.
The Search by Delivery Challan option in the Search menu allows to enter the Delivery Challan number and monitor the status of your shipment.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Shipment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour31.html","ViewPoAcknowledgement")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="four">How do I Add Shipment details ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
You can add shipment details through;  Order Details, Add Shipments.
The purchase order details and the schedule agreement details screen has a button in the bottom to add shipment details associated with those orders.
The Add Shipment option in the Shipments menu allows you to choose a specific purchase order or schedule agreement for which you would like to add the shipment details.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='Add Shipment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour61.html","AddPoAcknowledgement")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="five">How do I track status of shipments made by me ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
You can track the status of your shipments through: Order Details, View Shipments, Search.
The Purchase Order and Schedule Agreement details screen has a button "View Receipts" on the bottom. This takes you to the list of Receipts screen associated with the order. You can see the status of each receipt in the column. You can also see the reasons for rejection, if any, by clicking on the rejected quantity.
The View Shipments option in the Shipments menu allows you to choose the order for which shipment you are trying to track.
The Delivery Challan option in the Search menu allows you to enter your Delivery Challan number to track the status of your shipment.  This is the fastest way to track the status.
</td></tr>

<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='Track Status of Shipments';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour41.html","PoReceipts")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="six">How do I view Invoice details ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
You can view the Invoice details through: Invoices, Order Payment Details & Search
The Invoices menu offers you the choices of browsing through open and closed status invoices. You can view the details by clicking on the SAP invoice number in the list. The Vendor Invoice number in the list is the number on the invoice provided by you.
You can also view invoice details by clicking on the 'Payments Details' button in the order details of both Purchase Order and Schedule Agreements.
You can use the search option directly go the invoice details by providing your invoice number or the SAP invoice number. You can also search for invoices associated with a particular purchase order and drill down to details.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Invoice Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour50.html","InvoiceDetails")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="seven">How do I view Invoice Payment Details ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
You can view the payment status of any invoice by selecting the invoice details as per above and clicking on the Payment Details button. If the payment has been made, the check number, date and bank on which the check was drawn is displayed.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Invoice Payment Details';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATour53.html","InvoicePaymentDetails")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="eight">How do I view my Account Statement ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
From the Self Service menu, choose the A/c Statement option. You have to select the period for which Statement you would like to view.  To faster response from the system, keep your selection as brief as possible.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Account Statement';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss02.html","AcStatement")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="nine">How do I view the Outstanding Balance ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
From the Self Service menu, choose the Outstanding Balance option.  You will see the balance due to you from Enterprise.  Clicking on the balance amount gives you a list of the open invoices. Click on the invoice number to view details. Click on the Payment Details button to view the payment details.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='View Outstanding Balance';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss01.html","OutStandingBalance")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="ten">How do I communicate with the buyer at Enterprise ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
Apart from the conventional methods of telephone and fax, you can now communicate with the buyer at Enterprise efficiently via the mail feature in this portal.
</td></tr>

<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='Know how to communicate with Enterprise';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss06.html","mailing")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>

</tr>
</table>
<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class="faqheader"><a name="eleven">How do I inform Enterprise about changes in my Address ?</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
<table width="95%" align="center"><tr><td align="left" class="faqdata">
Use the Change Address option in the Self Service menu to enter details of your new address and press the submit button.  This new information is updated in Enterprise records.
</td></tr>
<tr>
<td><a href="javascript:void(0)" onMouseOver="window.status='Know how to update Enterprise about your change of address';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss04.html","ChangeAddress")>Take A Tour</a></td>
<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
</tr>
</table>

<br><br>
<%
	if(!userType.equals("3"))
	{
%>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a name="twelve">How do I View and Submit New QCF ?</a></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata">
		New QCF [Quotation Comparision Forms] can be Viewed by entering the Collective RFQ No number from "New" option in QCF Menu.
		Enter QCF form and click on Go,This will open a new window, Here Click on "Click Here To View Comments" link,That will show the detailed
		form of Quotation Comparision.Here we can enter the comments and submit the QCF.


		</td></tr>
		<tr>
		<td><a href="javascript:void(0)" onMouseOver="window.status='Know how to update Enterprise about your change of address';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss08.html","QCF")>Take A Tour</a></td>
		<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
		</tr>
		</table><br><br>



		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a name="thirteen">How do I View status of the QCF ?</a></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata">
		The Status of the QCF can viewed by clicking on the "Actions To Be Taken" option from QCF.
		This Page displays the list of submitted,returned QCF's.
		</td></tr>
		<tr>
		<td><a href="javascript:void(0)" onMouseOver="window.status='Know how to update Enterprise about your change of address';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss10.html","ListOfQCFs")>Take A Tour</a></td>
		<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
		</tr>
		</table><br><br>



		&nbsp;&nbsp;&nbsp;&nbsp;
		<font class="faqheader"><a name="forteen">How do I View Approved QCFs ?</a></font>
		&nbsp;&nbsp;&nbsp;&nbsp;<hr size="1" width=97%><br>
		<table width="95%" align="center"><tr><td align="left" class="faqdata">
		Approved,submitted and returned QCF's can be view by clicking on the "All" option from QCF Menu.
		Click on Collective RFQ No to View the QCF.
		</td></tr>
		<tr>
		<td><a href="javascript:void(0)" onMouseOver="window.status='Know how to update Enterprise about your change of address';return true;" onMouseOut="window.status=' ';return true;" onClick=funOpen("../../Htmls/TakeATour/TakeATourss11.html","AllQCFs")>Take A Tour</a></td>
		<td align="right"><a href="ezFAQs.jsp#top">Top<img border =0 src = "../../Images/Buttons/<%=ButtonDir%>/homeup.gif"></a></td>
		</tr>

		</table>
<%
	}
%>
	<br><br>


<br>

</td>
</tr>
</tbody>
</table>
<Div id="MenuSol"></Div>
</body>
</html>
