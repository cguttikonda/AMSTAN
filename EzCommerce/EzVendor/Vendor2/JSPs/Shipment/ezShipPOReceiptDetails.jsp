<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />


<%
	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	FormatDate formatDate = new FormatDate();
	final String order = "PURCHASEORDER";
	final String pos = "POSITIONNUMBER";
	final String seqn = "SEQUENCENUMBERPO";
	final String recno = "RECEIPTNUMBER";
	final String recdt = "RECEIPTDATE";
	final String delqty = "DELIVEREDQTY";
	final String backqty = "BACKORDERQTY";
	final String matl = "ITEM";
	final String puom = "PURCHASEUNIT";
	final String rrej = "REASONFORREJECTION";
	final String rqty = "REJECTEDQUANTITY";
	final String aqty = "APPROVEDQUANTITY";
	final String deldt = "CURRENTPLANNEDDELIVERYDATE";
	final String rdesc  = "REASONFORREJECTIONDESCRIPTION";
	final String amnt="AMOUNT";
	final String dcNum="REFDOCNO";

	String delNum="";
	String vorder = "";
	String vpos = "";
	String vseqn = "";
	String vrecno = "";
	Date vrecdt = null;
	String vdelqty = "";
	String vbackqty = "";
	String vmatl = "";
	String vpuom = "";
	String vrrej = "";
	String vrqty = "";
	String vaqty = "";
	Date vdeldt = null;
	String vrdesc = "";
	String recStatus = "";

	String base = request.getParameter("base");
	String ponum = request.getParameter("baseValue");

	String dcNumber=request.getParameter("DCNo"); 

	String desc = request.getParameter("material"); 
	String netOrderAmount = request.getParameter("OrderValue");
	String orderCurrency = request.getParameter("orderCurrency");
	Hashtable ht = new Hashtable();
	ht=(Hashtable)session.getAttribute("Material");

	String GRFlag=request.getParameter("GRFlag");
	if(dcNumber!=null)
	{
		dcNumber=dcNumber.trim();
	}

	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	Session.prepareParams(newParams);
	EzPurchaseReceipts retobj = new EzPurchaseReceipts();

	iparams.setOrderNumber(ponum);
	//iparams.setPositionNum(polin);

	if(GRFlag==null)
	{
		retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceiptsByDCNumber(newParams,dcNumber);
	}
	/*else
	{
		System.out.println("Entered GRNumberSearch");
		retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceiptsByGRNumber(newParams,dcNumber);
	}*/

	if(retobj.getRowCount()>0)
	{
		vrecdt =(Date)retobj.getFieldValue(0, recdt);
		double totalValue=0.00;

		for(int j=0;j<retobj.getRowCount();j++)
		{
			String netAmount = (String)retobj.getFieldValue(j, amnt);
			double nAmt=0.00;
			if(netAmount!=null)
			{
				netAmount=netAmount.trim();
				if(netAmount.equals("null"))
				{
					nAmt=0.00;
				}
				else
				{ 
					nAmt=Double.valueOf(netAmount).doubleValue();
				}
				totalValue=totalValue+nAmt;
			}
		}
 
	%>

	<html>
	<head>
	<title>Purchase Order Receipts</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	
<Script>
var tabHeadWidth=95
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
	<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<tr align="center"> 
    	<td class="displayheader">
    	<% if(!"PContracts".equals(base)){%>Purchase Order<%}else{%>Schedule Agreement<%}%> Receipts</td>
  	</tr>
	</table><br>
	<div align="left">
  	<table width="70%" border="2" align="center" bordercolor="#660066">
    	<tr align="center" valign="middle" > 
        <th width="15%" bordercolor="#ffffff" align="left"><% if(!"PContracts".equals(base)){%> PO No.<%}else{%>Agreement No.<%}%></th>
        <td width="18%" bordercolor="#ffffff"><%=Long.parseLong(ponum)%></td>
        <th width="15%" bordercolor="#ffffff"  align="left"> Date</th>
	<td width="15%" bordercolor="#ffffff"><%=formatDate.getStringFromDate(vrecdt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
	<th width="15%" bordercolor="#ffffff"  align="left"> Value[<%= orderCurrency %>]</th>
      	<td width="22%" bordercolor="#ffffff">
	<%
		out.println(myFormat.getCurrencyString(netOrderAmount));
	%>
	</td>
    	</tr>
  	</table><br>
	</div>
	<DIV id="theads">
	<table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr align="center" valign="middle"> 
    	<th width="5%">Line</th>
    	<th width="7%">Mat. No</th>
    	<th width="14%">Description</th>
    	<th width="9%">DC No.</th>
    	<th width="11%">GR No.</th>
    	<th width="11%">GR Date</th>
    	<th width="11%">Del. Qty</th>
    	<th width="11%">App. Qty</th>
    	<th width="10%">Rej. Qty</th>
    	<th width="11%">Status</th>
	</tr>
	</Table>
	</DIV>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">	
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<%
	int noofrows = retobj.getRowCount();
	for (int i=0; i < noofrows ; i++)
	{
		vorder = "";
		vpuom = (String)retobj.getFieldValueString(i, puom);
		vpos = (String)retobj.getFieldValueString(i, pos);
		//vseqn = (String)retobj.getFieldValueString(i, seqn);
		vrecno = (String)retobj.getFieldValueString(i, recno);
		vrecdt =(Date)retobj.getFieldValue(i, recdt);
		vdelqty = (String)retobj.getFieldValueString(i, delqty);
		//vdelqty  = vdelqty  + vpuom;
		//vbackqty = (String)retobj.getFieldValueString(i, backqty);
		//vbackqty  = vbackqty  + vpuom;
		vmatl = (String)retobj.getFieldValueString(i, matl);
		//vrrej = (String)retobj.getFieldValueString(i, rrej);
		vrqty = (String)retobj.getFieldValueString(i, rqty);
		vaqty =(String)retobj.getFieldValueString(i, aqty);
		vdeldt =(Date)retobj.getFieldValue(i, deldt);
		vrdesc =(String)retobj.getFieldValueString(i, rdesc);
		delNum =(String)retobj.getFieldValueString(i, dcNum);
		recStatus = retobj.getFieldValueString(i, "STATUSTEXT");
		%>
		<tr align="center"> 
		<td width="5%"><%=vpos%></td>
		<%
		try{
			out.println("<td  width='7%' title='"+Long.parseLong(vmatl)+"'><input type='text' size='5' class='tx' value=\""+Long.parseLong(vmatl)+"\">");
		}catch(NumberFormatException nfe){
			out.println("<td  width='7%' title='"+vmatl+"'><input type='text' size='5' class='tx' value=\""+vmatl+ "\" >");
  		}%>
		</td>
		<td width="14%" title="<%=ht.get(vmatl)%>" align="left"><input type="text" class=InputBox  value="<%=ht.get(vmatl)%>" size="8" class="tx"></td>
		<td width="9%" align="left" title="<%=delNum%>"><input type="text" class=InputBox  value="<%=delNum%>" size="6" class="tx"></td>
		<td width="11%" align="left" title="<%=vrecno%>"><input type="text" class=InputBox  value="<%=vrecno%>" size="6" class="tx"></td>
		<td width="11%"><%=formatDate.getStringFromDate(vrecdt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
		<td width ="11%" align="left" title="<%=vdelqty%>"><input type="text" class=InputBox  value="<%=vdelqty%>" size="7" class="tx"></td>
		<td width="11%" align="left" title="<%=vaqty%>" ><input type="text" class=InputBox  value="<%=vaqty%>" size="7" class="tx"></td>
		<%if((vaqty.trim()).equals("0.000")){ %>
			<td width ="10%" align="right"><a href="../Purorder/ezReasonForRejection.jsp?Reason=<%=vrdesc%>&order=<%=ponum%>&line=<%=vpos%>"><%=vrqty%></a></td>
		<%}else{%>
		 	<td width ="10%" align="right"><%=vrqty%></td>
		<%}%>
		<td width="11%" align="left" title="<%=recStatus%>">
		<%
		if(recStatus.equals("Invoiced"))
		{
		%>	<a href="ezPoPaymentDetails.jsp?PurchaseOrder=<%=ponum%>&base=<%=base%>&POPrice=<%=netOrderAmount%>&orderCurrency=<%=orderCurrency%>">Invoiced</a>
		<%}
		else{
			out.println("<input type='text' class='tx' size='7' value='"+ recStatus +"'>");
		}%></td>
  		</tr>
    		<%
	}// end of for
	%>
	</table>
	</div>
	<div id="head1" style="position:absolute;top:94%;left:10%">
	<font color='red'><center>Rejected Quantity hyperlink takes you to Rejection Reasons</center></font>
	<%
}
else{
%>	<html>
	<head>
	<title>Purchase Order Receipts</title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	</head>
	<body>
	<br><br><br><br><br><br>
	<table id="Table1" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr align="center"> 
	<td class="displayheader">
		No Purchase Order Receipts Exists for Delivery Challan No: <%=dcNumber%>
	</td>
	</tr></table>
	<br>
	 <center><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" onMouseover="window.status=' '; return true"  onClick='JavaScript:top.history.back()' border="none" valign="center"></center>

<%}%>
<Div id="MenuSol"></Div>
</body>
</html>

