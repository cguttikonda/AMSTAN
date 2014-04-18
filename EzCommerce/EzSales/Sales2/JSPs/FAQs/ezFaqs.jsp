<html>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<head>

<title>FAQs</title>
<script>
	function funOpen(obj,obj1)
	{
		// dow = window.open(obj,"Take","left=20,top=10,height=800,width=1250,status=no,toolbar=no,menubar=no,location=no")
			window.open(obj,"newWindow","menubar=no,scrollbars=no,toolbar=no,left=10,top=10,width=1000,height=700");
	}
	var tabHeadWidth=100
	var tabHeight="65%"
</script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Style>
.tablehelp{}
	table.tablehelp{
	  border-right:#00385D 1px inset;
	  border-top: #00385D 1px inset; 
	  border-left: #00385D 1px inset;
	  border-bottom: #00385D 1px inset;
	  font-family: verdana, arial;
	}
	table.tablesubhelp{
	   border-right#FFCCCC 1px outset; 
	   border-top: #00385D 1px outset;
	   border-left: #00385D 1px outset;
	   border-bottom: #FFCCCC 1px outset;    
	   font-family: verdana, arial;
	}
	.thhelp{}
	th.thhelp{
		font-family: verdana, arial; 
		font-size: 9px;
		font-style: normal;
		color: #000000;
		background-color: #FFCCCC
	
	}
	
	.tdhelp{}
	td.tdhelp{
		font-family: verdana, arial;
		font-size: 9px;
		font-style: normal;
		color: #00385D;
		background-color: #E1E8EE
	
	}
</Style>	
</head>

<BODY background="../../../../EzCommon/Images/Body/NOTEBOOK.JPG" onContextMenu="return true" scroll=no onLoad="scrollInit()" onResize="scrollInit()">
<%
            String display_header = "Frequently Asked Questions";         
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<Div id="faqDiv" style="overflow:auto;position:absolute;width:100%;height:100%;top:0%;">
<TABLE id="faqTab" border=0 cellPadding=0 bgcolor="#FFFFFF" cellSpacing=0 style="width=90%" align="center">
<TBODY>
<Tr><a name="top"></a>		
</Tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#fifteen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How is Product search done and Place Order ?  <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="question.gif" style="border:0;" background-color="#DEDCB6">

		<a href = "ezFaqs.jsp#one">
			<font size=2 style="color:blue;">How can I Create Sales Orders ?<br></font>
		</a>
	</td>
</tr>

<%
	String UserRole = (String)session.getValue("UserRole");
	
	if(UserRole.equals("CM"))
	{
	
%>



<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#three">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I View Sales Order Details ? <br></font>
		</a>
	</td>
</tr>


<%

}

%>


<%
	
	
	if(!UserRole.equals("CM"))
	{
	
%>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#eighty one">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I View Sales Order Details ? <br></font>
		</a>
	</td>
</tr>

<%

}

%>



<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#four">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">What is the difference between Sales Order No and PO No ? <br></font>
		</a>
	</td>
</tr>




<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#five">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">I have already created an order. Can I copy order for the same products?  <br></font>
		</a>
	</td>
</tr>




<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#six">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How can I view Invoices ? <br></font>
		</a>
	</td>
</tr>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#seven">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How can I get Invoice Aging Report ? <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#eight">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I view Account Ledger ?  <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#nine">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I search Sales Orders ?  <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#ten">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How can I view Catalog ? <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#eleven">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How can I add products to shopping cart ?<br></font>
		</a>
	</td>
</tr>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#tweleve">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How can I create my own Catalog ? <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#thirteen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I View / Edit / Delete my own Catalog(Favorites) ? <br></font>
		</a>
	</td>
</tr>







<%
	
	
	if(UserRole.equals("CM"))
	{
	
%>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#fourteen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I view Billing Details ?  <br></font>
		</a>
	</td>
</tr>



<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#thirty">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How to create Ship to Address ?
<br></font>
		</a>
	</td>
</tr>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#thirty one">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How to change Ship to Address ?
<br></font>
		</a>
	</td>
</tr>




<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#sixteen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How to create Shipment ?
 <br></font>
		</a>
	</td>
</tr>

<%

}

%>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#thirty eight">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How to view Dispatch Details ?
 <br></font>
		</a>
	</td>
</tr>

<%
	
	if(!UserRole.equals("CM")) 
	{
	
%>




<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#forty one">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How to acknowledge shipment ?  <br></font>
		</a>
	</td>
</tr>

<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#seventeen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;">How can I change my Password ?
 <br></font>
		</a>
	</td>
</tr>

<%

}


%>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#nineteen">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How to contact AF Supply ?
<br></font>
		</a>
	</td>
</tr>


<TR >

	<TD width="50%" class="pagestyle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href = "ezFaqs.jsp#twenty one">
			<img src="question.gif" style="border:0;" background-color="#DEDCB6">
			<font size=2 style="color:blue;"> How to upload an image ?
<br></font>
		</a>
	</td>
</tr>








<br>
<br>

<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="fifteen">
<font size="3" face="Arial" color="maroon"><b>How is product search done and Place Order ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">

Select <b>Find Product --> Search </b> option from the main menu.In product search we have three search criterion,either by Vendor Catalog search or by Product Id search or Advanced search can be done.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/productsearch/TakeATour10.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>



<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<Tr>
	<br>
<table width="85%" align="center">
<tr><td align="left" class="faqdata">
<a name="one">
<font size="3" face="Arial" color="maroon"><b>How can I Create Sales Order ?</b></font>
</a></font>
</tr>
		</table>
<br>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
You can create Sales Order by selecting <b>Manage Orders --> Create Order--> By Favorites / By Copy Order / From Shopping Cart / Saved Orders</b> option from the main menu.
While creating an order you can submit this order by clicking on 'Submit To SAP' button.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/createorder/TakeATour11.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a> </td> 
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>



<!--<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<a name="two">
<font size="3" face="Arial" color="maroon"><b>What are the different types of Sales Orders ?</b> </a> </font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">


<font face="Arial" size=2 color="#000072"> 

Sales Order may be Open, Closed, Saved.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("../../Htmls/TakeATour/CreateOrder.html"," Sales Order Status")'><font size="2" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>-->
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

</td>
<%
	
	if(UserRole.equals("CM")) 
	{
	
%>


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br>

<a name="three">
<font size="3" face="Arial" color="maroon"><b>How can I View Sales Order Details ?</b>
</a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Sales Orders may be <b>Open, Closed, Saved.</b> To view Sales Orders,
Select  <b>Manage Orders --> View Orders --> Open Orders/Closed Orders /Saved Orders</b>.
This shows you the list of orders. In this order list, click on  'Sales Order No'  hyperlink to view the sales order details.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/salesorderdetails/TakeATour22.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<%

}

%>
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

</td>
<%
	
	if(!UserRole.equals("CM")) 
	{
	
%>
		
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br>

<a name="eighty one">
<font size="3" face="Arial" color="maroon"><b>How can I View Sales Order Details ?</b>
</a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Sales Orders may be <b>Open, Closed, Saved.</b> To view Sales Orders,
Select  <b>Manage Orders --> View Orders --> Submitted Orders /Saved Orders</b>.
This shows you the list of orders. In this order list, click on  'Sales Order No'  hyperlink to view the sales order details.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/salesorderdetails1/TakeATour22.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		
<%

}


%>
		

<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>



<a name="four">
<font size="3" face="Arial" color="maroon"><b>What is the difference between Sales Order No and PO No ? </b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
 Customers provide Purchase Order No at the time of Order creation whereas Sales Order No is generated by  the  system itself through some internal processing.
</font>
</p>
<tr>
		<td class="pagestyle"><!--<a href='javascript:funOpen("../../Htmls/TakeATour/CreateOrder.html","Create Sales Order")'><font size="2" color="darkgreen"><i><b>Take A Tour</b></i></font></a>--></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>


<a name="five">
<font size="3" face="Arial" color="maroon"><b>I have already created an order. Can I copy order for the same products? </b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Yes, you can Copy Order for the same products by selecting Copy Order option. Select<br><b> Manage Orders --> Create Order-->By Copy Order</b> option from the main menu. This displays the list of all the orders you have submitted before. Select the order number from the list and click on 'Copy' button. When you click on copy button a page containing the products and quantities displays. Enter PO No, Required Date  and proceed further.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/canicopyorder/TakeATour166.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="six">
<font size="3" face="Arial" color="maroon"><b>How can I view invoices ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
We have Open invoices and closed invoices,to view open invoices
Select <b>Invoices -> Open Invoices</b> option from the main menu.Here it displays available open invoices. To get the invoice details click Billing Doc.no..For knowing shipment details select Delv.Doc.No.
<br>
To view closed invoices
Select <b>Invoices -> Closed Invoices</b> option from the main menu.By specifying from date and to date it displays available closed invoices. To get the invoice details click Billing Doc.no..
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/viewinvoices/TakeATour333.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>


<a name="seven">
<font size="3" face="Arial" color="maroon"><b>How can I get Invoice Aging Report ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Select <b>Invoices -> Aging</b> option from the main menu. This shows Invoice Aging Report page. To view invoice details click Cust.Inv.No.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/invoice ageing report/TakeATour44.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<br><br>

<a name="eight">
<font size="3" face="Arial" color="maroon"><b>How can I view Account Ledger ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Select <b>Invoices -> A/C Ledger </b> option from the main menu. This displays Statement of A/C as in Account Books if we specifying from date and to date.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/acledger/TakeATour55.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>


<a name="nine">
<font size="3" face="Arial" color="maroon"><b>How can I search Sales Orders ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
This search is limited to orders created online.
Select <b>Web Search </b> option from the main menu. Search pattern can be decided by Web Order No./Purchase Order No./Product No./Product Desc.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/searchsalesorders/TakeATour666.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br>

<a name="ten">
<font size="3" face="Arial" color="maroon"><b>How can I view Catalog ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
In catalog we have Manufacturer catalogs  and Favorites,to view Manufacturer catalogs
Select <br><b>Find Product --> Manufacturer catalogs</b> option from the main menu. 
This displays manufacturer catalogs, by selecting the manufacturer catalog it shows different products and their descriptions.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/viewcatalog/TakeATour7.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="eleven">
<font size="3" face="Arial" color="maroon"><b>How can I add products to shopping cart ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Select <b>Find Product -->Manufacturer Catalogs/Favorites </b> option from the main menu. This displays the list of available Catalogs/Favorites. To view the  list of available products in a catalog, click on catalog name. You need to add  products to the shopping cart. To do this select the products from the list and press 'Add To Cart' button. A confirmation message displays. Now click on ' Cart Items' button. This shows the list of  the products, you have added to the 'Shopping Cart'.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/addtocart/TakeATour17.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="tweleve">
<font size="3" face="Arial" color="maroon"><b>How can I create my own Catalog ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
Select <b>Find Product --> Organize Favorites</b> option from the main menu. This displays  a screen having 'New', 'View', 'Edit' and 'Delete' buttons at the top. Click on 'New' button to create a new catalog. This catalog name is the name of your catalog. After creating a catalog if you click on group name hyperlink, a screen displays. This screen is  having ' Add Products' and 'Back' button at the bottom. Click on 'Add Products' button. This displays the list of the products. Select product(s) and click on 'Add To Group' button to  add these products to your group.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/createowncatalog/TakeATour8.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>


<a name="thirteen">
<font size="3" face="Arial" color="maroon"><b>How can I View / Edit / Delete my Own Catalog(Favorites)?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
You can View/Edit/Delete your Favorite(s) by selecting <b>Find Product --> Organize Favorites</b> option from the main menu.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/viewingowncatalogs/TakeATour9.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>



<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

</td>
<%
	
	if(UserRole.equals("CM")) 
	{
	
%>


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="fourteen">
<font size="3" face="Arial" color="maroon"><b>How can I view Billing Details ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
You can view payment details of an Closed order. To do so,
Select <br><b>Manage Orders --> View Orders --> Closed Orders</b> option from the main menu. This displays Closed Order List. Click on 'Sales Order No' hyperlink to view the sales order payment details.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/viewingbillingdetails/TakeATour18.2.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		

<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="thirty">
<font size="3" face="Arial" color="maroon"><b>How to create Ship to Address ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">

Select <b>My Account -->Add Ship to </b> by doing so, you can enter the shipping address.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/createshipaddress/TakeATour222.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		

<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="thirty one">
<font size="3" face="Arial" color="maroon"><b>How to change Ship to Address ?</b></a></font>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">

Select <b>My Account --> Edit Ship to</b> by doing so, you can change the shipping address. 
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/changeshipaddress/TakeATour222.2.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br> 

<a name="sixteen">
<font size="3" face="Arial" color="maroon"><b>How to create Shipment ?</b></a></font><br>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
 To do so, Select&nbsp;<b> Shipping & Delivery --> Create Shipment</b> option from the main menu. Here you can enter shipment details for delivery No. of selected sales order No.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/shipmentdetails/TakeATour78.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

		
<%
	}
%>


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>


<a name="thirty eight">
<font size="3" face="Arial" color="maroon"><b>How to view Dispatch Details ?</b></a></font><br>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
 To do so, Select&nbsp;<b> Shipping & Delivery --> Acknowledged </b> option from the main menu. Here you can view the Dispatch Details of Shipment No. which are acknowledged.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/dispatchdetails/TakeATour79.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >



</td>
<%
	
	if(!UserRole.equals("CM")) 
	{
	
%>

		

		


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br>
<a name="forty one">
<font size="3" face="Arial" color="maroon"><b>How to acknowledge Shipment ?</b></a></font>

<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
 To do so, Select&nbsp;<b>Shipping & Delivery --> To Be acknowledged</b> option from the main menu. 
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/tobeacknowledged/TakeATour27.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<br><br>
<a name="seventeen">
<font size="3" face="Arial" color="maroon"><b>How can I change my Password ?</b></a></font><br>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
From security point of view, it is advisable to change your password time to time. You will be having change password option after your successful login. Enter your old password, new password and confirm new password by re-entering it again. Click on 'Save' button to activate new password.  Use the new password whenever you login again.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/changepassword/TakeATour12.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		
<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


		
<%
	}
%>


<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >


<br><br>

<a name="nineteen">
<font size="3" face="Arial" color="maroon"><b>How to contact AF Supply ?</b></a></font><br>
<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
  To do so, Select&nbsp;<b>Self Services --> Contact Us</b> option from the main menu. Here we have provided Corporate office Address of AF Supply, E-mail id, website and persons to be contacted.
</font>
</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/contact/TakeATour144.1.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>




<Table width=85% id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<br><br>

<a name="twenty one">
<font size="3" face="Arial" color="maroon"><b>How to uplaod an image ?</b></a></font>

<p>
<table width="80%" align="center">
<tr><td align="left" class="faqdata">
<font face="Arial" size=2 color="#000072">
 To do so, Select&nbsp;<b>Find Product --> Manufacturer Catalog --> Vendor Catalog</b> option from the main menu. This will take you to the subsequent page. Here you can select Upload Docs to change the images with the help of options provided there.
</font>

</p>
<tr>
		<td class="pagestyle"><a href='javascript:funOpen("ezFaqs/imageupload/TakeATour21.1.html","Create Sales Order")'><font size="3" color="darkgreen"><i><b>Take A Tour</b></i></font></a></td>
		<td align="right" class="pagestyle"><a href="ezFaqs.jsp#top"><img border =0 src = "go_up_arrow.png"></a></td>
</tr>
		</table>
		


</Tr>
</Table>
</Div>
<div id="MenuSol"  ></div>
</body>
</html>
