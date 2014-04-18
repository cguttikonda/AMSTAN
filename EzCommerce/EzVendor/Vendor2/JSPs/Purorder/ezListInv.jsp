<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%
	ezc.ezparam.EzInvoice SeqInv = new ezc.ezparam.EzInvoice();
	
	String searchField = request.getParameter("searchField");
	String base = request.getParameter("base");
	String invoiceFlag = request.getParameter("InvStat");
	String vendor=(String) session.getValue("SOLDTO");
	String purnum = "";
	String InvStatus	= request.getParameter("InvStat");
	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
	boolean isShowDates = false;
	if(searchField==null || "null".equals(searchField) || "".equals(searchField) )
	{
			isShowDates = true;
	}
		
	if ( invoiceFlag.equals("P") )
	{
	
		ezc.ezshipment.client.EzShipmentManager manager = new ezc.ezshipment.client.EzShipmentManager();
		
		EzcParams ezcParams=new EzcParams(true);
		ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
		
		inStruct.setBase("POIN");
		inStruct.setVendor(vendor);
		inStruct.setDocnum(searchField);

		ezcParams.setObject(inStruct);
		Session.prepareParams(ezcParams);

		SeqInv = (EzInvoice) manager.ezGetInvoicesForGR(ezcParams);
	}
	else{
%>
		<%@ include file="../../../Includes/JSPs/Purorder/iListInv.jsp"%>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezConvertDates.js"></script>
<Script>
	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate)
	{
<%
		if(isShowDates){
%>
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&InvStat=<%=invoiceFlag%>&listBack=Y&searchField=<%=searchField%>&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value
<%
		}else{
%>
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&InvStat=<%=invoiceFlag%>&listBack=Y&searchField=<%=searchField%>"
<%
		  }	
%>
	}
	function ezSubmit(){
	
		

		document.myForm.action = "ezListInv.jsp?InvStat=P";
		document.myForm.submit();
	}

	function getDefaultsFromTo(){
		
<%
		if(isShowDates){
		if(fromDate!= null && toDate != null){
%>
			document.myForm.ToDate.value = "<%=toDate%>";
			document.myForm.FromDate.value = "<%=fromDate%>";
			//alert("flag::true")
<%
		}
		else{
%>
			//alert("flag::false")
			toDate = new Date();
			today = toDate.getDate();
			thismonth = toDate.getMonth()+1;
			thisyear = toDate.getYear();

			fromDate =  new Date();
			fromDate.setDate((toDate.getDate()-30));
			prevdate =  fromDate.getDate();
			prevmonth = fromDate.getMonth()+1;
			prevyear =  fromDate.getYear();

			if(!document.all){
				thisyear = thisyear+1900;
				prevyear = prevyear+1900;
			}
			if(today < 10)
				today = "0"+today;
			if(prevdate < 10)
				prevdate = "0"+prevdate;	

			if(thismonth < 10)
				thismonth = "0" + thismonth;
			if(prevmonth < 10)
				prevmonth = "0" + prevmonth;	
			document.myForm.ToDate.value = ConvertDateFormat(today+'.'+thismonth+'.'+thisyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
			document.myForm.FromDate.value = ConvertDateFormat(prevdate+'.'+prevmonth+'.'+prevyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
			//alert(ConvertDateFormat(today+'.'+thismonth+'.'+thisyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>'))
<%

		}
		}	
%>
	}
</Script>
	
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example" scroll="no" onLoad="getDefaultsFromTo()">
	<form name="myForm">
	<input type="hidden" name="InvStat" value="<%=InvStatus%>">
	
<%
	String display_header	= "";
	if("C".equals(InvStatus))
	{
		display_header ="Closed Invoices";
	}
	else
	{
		display_header ="All Invoices";
	}
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	String clickString = "onclick='ezSubmit()'";
	if(isShowDates){
%>

		<%@ include file="../Misc/ezSelectDate.jsp"%>		
<% 
	}
%>
		<div id="container">
		<div id="demo">
		<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
		<thead>
			<tr>
				<th>Vendor Inv.Number</th>
				<th>SAP Inv.Number</th>
				<th>Invoice Date</th>
				<th>Pay. Due Date</th>
				<th>PO Number</th>
				<th>Currency</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
<%
	ezc.ezcommon.EzLog4j.log("invoiceFlag>>>>>>>>>>>>>"+invoiceFlag ,"I");

	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	if(base!=null)
	{
		if(base.equals("Invoice")){
			mySearch.searchLong(SeqInv,"INVOICENUMBER",searchField);
		}else if(base.equals("VendorInvoiceNumber")){
			mySearch.search(SeqInv,"REFDOC",searchField);
		}
	}
                      
	int count=0;
	int seqRowCount = 0;
	if(SeqInv!=null)
		seqRowCount = SeqInv.getRowCount();
	if(seqRowCount>0){
		FormatDate formatDate = new FormatDate();
		
		String sortItems[] = {"INVOICEDATE"};
		SeqInv.sort(sortItems,false);

		String invNumber = new String();
		double invConAmt = 0;

		/// INV LIST CONSOLIDATION STARTS HERE
		Hashtable invAmtHT = new Hashtable();
		for(int i=0;i<seqRowCount;i++)	{
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
					continue;
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("OV") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("S"))
					continue;
			if(!invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER"))){
				invAmtHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"AMOUNT"));
			}
			else
			{
				invNumber = SeqInv.getFieldValueString(i,"INVOICENUMBER");
				try{
					invConAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"))+Double.parseDouble(invAmtHT.get(invNumber).toString());
				}catch(Exception numFmtEx)
				{
					System.out.println(" <<<<<<<<<< Exception Occured at :: "+i+" while consolidating InvList with Invoice Number :: "+invNumber+" >>>>>>>>>> "+numFmtEx.getMessage());
					invConAmt = Double.parseDouble((String)invAmtHT.get(invNumber));
				}
				invAmtHT.put(invNumber,new Double(invConAmt).toString());
			}	
		
		}
	
	
		/// INV LIST CONSOLIDATION ENDS HERE
	
		String amt = null;

		String vndInvNumber = "";
		String sapInvNumber = "";
		String invDate	    = "";
		String payDueDate   = "";
		String poNumber	    = "";
		String invCurrency  = "";
		String invAmount    = "";
		String compCode	    = "";
		String postDate	    = "";
		String docType      = "";
		
		for (int i= 0;i<seqRowCount;i++){
			if (invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER"))){
				try{
					amt = (String)invAmtHT.get(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
					invAmtHT.remove(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
				}
				catch(Exception ae){
					amt = "0";
				}

				if(!"0.00".equals(myFormat.getCurrencyString(amt))){
					count = count+1;

					vndInvNumber = SeqInv.getFieldValueString(i,"REFDOC");
					if(vndInvNumber == null || vndInvNumber.trim().length() == 0  || "null".equals(vndInvNumber))
						vndInvNumber = "";
					sapInvNumber	= SeqInv.getFieldValueString(i,"INVOICENUMBER");	
					invDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					payDueDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"CLEAR_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					compCode	= SeqInv.getFieldValueString(i,"COMPCODE");
					invCurrency	= SeqInv.getFieldValueString(i,"INVOICECURRENCY");
					invAmount	= myFormat.getCurrencyString(amt);
					postDate	= formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"));
					docType		= (String)SeqInv.getFieldValue(i,"DOCTYPE");

					poNumber  = null ;
					try{
						poNumber = Long.parseLong(SeqInv.getFieldValueString(i,"PURCHASEORDER"))+"";
					}catch(Exception numFmtEx)
					{
						poNumber = SeqInv.getFieldValueString(i,"PURCHASEORDER");
					}
					if(poNumber == null ||"".equals(poNumber))
						poNumber = "";
					if(payDueDate == null ||"".equals(payDueDate))
						payDueDate = "";	

					//out.println("<row id='"+sapInvNumber+"'><cell>"+vndInvNumber+"</cell><cell><![CDATA[<nobr><a href=\"JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','"+sapInvNumber+"','"+poNumber+"','"+compCode+"','"+SeqInv.getFieldValue(i,"DOCTYPE")+"','"+invDate+"','"+invCurrency+"','"+invAmount+"','"+formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"')\" onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+sapInvNumber+"</a></nobr>]]></cell><cell>"+invDate+"</cell><cell>"+payDueDate+"</cell><cell>"+poNumber+"</cell><cell>"+invCurrency+"</cell><cell>"+invAmount+"</cell></row>");
%>
					<tr>
						<td align="center"><%=vndInvNumber%></td>
						<td align="center"><%="<a href=\"JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','"+sapInvNumber+"','"+poNumber+"','"+compCode+"','"+SeqInv.getFieldValue(i,"DOCTYPE")+"','"+invDate+"','"+invCurrency+"','"+invAmount+"','"+formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"')\" onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+sapInvNumber+"</a>"%></td>
						<td align="center"><%=invDate%></td>
						<td align="center"><%=payDueDate%></td>
						<td align="center"><%=poNumber%></td>
						<td align="center"><%=invCurrency%></td>
						<td align="right"><%=invAmount%></td>
					</tr>
<%
				}
			
			}		
		}
	}
%>
</tbody>
</table>
</div>
<div class="spacer"></div>
</div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>