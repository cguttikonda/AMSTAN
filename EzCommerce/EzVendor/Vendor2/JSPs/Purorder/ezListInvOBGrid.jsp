<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%
	int totInv = 0;
	String checked 		= "";
	String dbcrInd		= "";
	String invoiceFlag 	= request.getParameter("InvStat");
	String invCur 		= request.getParameter("invCur");
	String invBal 		= request.getParameter("invBal");
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();	
	
	java.util.Hashtable dbcrIndHash = new java.util.Hashtable();
	dbcrIndHash.put("H","");
	dbcrIndHash.put("S","-");
%>	
<%@ include file="../../../Includes/JSPs/Purorder/iListOPENInvoices.jsp"%>
<%
	
	int Count = 0;
	if(SeqInv != null)
		Count = SeqInv.getRowCount();
	
	out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	out.println("<rows>");
	
	if(Count > 0)
	{
		String invNo 		= "";
		String invCr 		= "";
		String invDt 		= "";
		String invAmt		= "";
		String appAmt		= "";
		String pdAmt 		= "";
		String outputString 	= "";
		String invoiceNumber	= "";
		for(int i=0;i<Count;i++)
		{
			totInv++;
			if(i == 0)
				checked = "checked";
			else
				checked = "";
			
			dbcrInd = (String)dbcrIndHash.get(SeqInv.getFieldValueString(i,"DBCRINDICATOR"));
			if(dbcrInd == null || "null".equals(dbcrInd))
				dbcrInd = "";
			
			invoiceNumber	= Long.parseLong(SeqInv.getFieldValueString(i,"INVOICENUMBER"))+"";
			invNo = SeqInv.getFieldValueString(i,"REFDOC");
			
			invCr = SeqInv.getFieldValueString(i,"INVOICECURRENCY");
			invDt = formatDate.getStringFromDate((java.util.Date)SeqInv.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			invAmt= dbcrInd+" "+myFormat.getCurrencyString(SeqInv.getFieldValueString(i,"AMOUNT"));
			appAmt= dbcrInd+" "+myFormat.getCurrencyString(SeqInv.getFieldValueString(i,"PAIDAMOUNT"));

			if(invCr == null || "null".equals(invCr))
				invCr = "USD";
			
			outputString  = "<row id='"+SeqInv.getFieldValue(i,"INVOICENUMBER")+"|"+invDt+"|"+SeqInv.getFieldValue(i,"AMOUNT")+"|"+SeqInv.getFieldValue(i,"COMPCODE")+"|"+SeqInv.getFieldValue(i,"INVOICECURRENCY")+"|"+(formatDate.getStringFromDate((java.util.Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY))+"|"+SeqInv.getFieldValue(i,"DOCTYPE")+"|"+SeqInv.getFieldValue(i,"PURCHASEORDER")+"'>";
			outputString += "<cell></cell><cell>"+invNo+"</cell>";
			outputString += "<cell><![CDATA[<nobr><a href='ezInvoiceDetails.jsp?invnum="+SeqInv.getFieldValue(i,"INVOICENUMBER")+"&amp;invDate="+invDt+"&amp;invAmount="+SeqInv.getFieldValue(i,"AMOUNT")+"&amp;compCode="+SeqInv.getFieldValue(i,"COMPCODE")+"&amp;invCur="+SeqInv.getFieldValue(i,"INVOICECURRENCY")+"&amp;PostDate="+ formatDate.getStringFromDate((java.util.Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"&amp;docType="+SeqInv.getFieldValueString(i,"DOCTYPE")+"&amp;purNum="+SeqInv.getFieldValueString(i,"PURCHASEORDER")+"' onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+invoiceNumber+"</a></nobr>]]></cell>";
			//outputString += "<cell>"+invDt+"</cell><cell>"+invAmt+"</cell><cell>"+appAmt+"</cell><cell>"+appAmt;
			outputString += "<cell>"+invDt+"</cell><cell>"+invAmt+"</cell><cell>"+appAmt;
			if(i == Count-1)
			{
				outputString += "<![CDATA[<nobr><input type=hidden name='totInv' value='"+totInv+"'></nobr>]]>";
			}
			outputString += "</cell></row>";
			out.println(outputString);
		}
	}	
	else
	{
		out.println("<row id='0'></row>");
	}
	out.println("</rows>");	
%>