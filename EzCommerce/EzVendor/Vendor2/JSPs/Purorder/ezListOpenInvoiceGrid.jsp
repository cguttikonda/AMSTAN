<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iListOPENInvoices.jsp" %>
<%
	FormatDate formatDate = new FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	
	int Count = 0;
	int rowCnt= 0;
	if(SeqInv != null)
		Count = SeqInv.getRowCount();
	
	Hashtable invAmtHT = new Hashtable();
	if (Count > 0)
	{
		SeqInv.sort(new String[]{"INVOICEDATE"},false);
		String invNumber = new String();
		double invConAmt = 0;
		for(int i=0;i<Count;i++)
		{
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
				continue;
			if(!invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER")))
			{
				invAmtHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"AMOUNT"));
			}
			else
			{
				invNumber = SeqInv.getFieldValueString(i,"INVOICENUMBER");
				try
				{
					invConAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"))+Double.parseDouble(invAmtHT.get(invNumber).toString());
				}
				catch(Exception numFmtEx)
				{
					invConAmt = Double.parseDouble((String)invAmtHT.get(invNumber));
				}
				invAmtHT.put(invNumber,new Double(invConAmt).toString());
			}	
		}
	}	

	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if (Count > 0)
	{
		String vndInvNumber = "";
		String sapInvNumber = "";
		String invDate	    = "";
		String payDueDate   = "";
		String poNumber	    = "";
		String invCurrency  = "";
		String invAmount    = "";
		String compCode	    = "";
		String amt = null;
		for (int i= 0; i<Count; i++)
		{
			if(SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
			{
				try
				{
					amt = (String)invAmtHT.get(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
				}
				catch(Exception ae)
				{
					amt = "0.00";
				}
				if(!"0.00".equals(myFormat.getCurrencyString(amt)))
				{
					vndInvNumber 	= SeqInv.getFieldValueString(i,"REFDOC");
					if(vndInvNumber == null || vndInvNumber.trim().length() == 0  || "null".equals(vndInvNumber))
						vndInvNumber = "&amp;nbsp;";
					sapInvNumber	= SeqInv.getFieldValueString(i,"INVOICENUMBER");
					invDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					payDueDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"PAYMENTDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					poNumber 	= SeqInv.getFieldValueString(i,"PURCHASEORDER").trim();
					compCode	= SeqInv.getFieldValueString(i,"COMPCODE");
					invCurrency	= SeqInv.getFieldValueString(i,"INVOICECURRENCY");
					invAmount	= SeqInv.getFieldValueString(i,"AMOUNT");
					invAmount	= myFormat.getCurrencyString(invAmount);
					rowCnt		= rowCnt+1;
					out.println("<row id='"+sapInvNumber+"'><cell>"+vndInvNumber+"</cell><cell><![CDATA[<nobr><a href=\"JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','"+sapInvNumber+"','"+poNumber+"','"+compCode+"','"+SeqInv.getFieldValue(i,"DOCTYPE")+"','"+invDate+"','"+invCurrency+"','"+invAmount+"','"+formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"')\" onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+sapInvNumber+"</a></nobr>]]></cell><cell>"+invDate+"</cell><cell>"+payDueDate+"</cell><cell>"+poNumber+"</cell><cell>"+invCurrency+"</cell><cell>"+invAmount+"</cell></row>");
				}
			}
		}
		if(rowCnt == 0)
		{
			out.println("<row id='"+rowCnt+"'></row>");
			ezc.ezcommon.EzLog4j.log("<row id='"+rowCnt+"'></row>","I");
		}	
	}	
	else
	{
		out.println("<row id='"+Count+"'></row>");
		ezc.ezcommon.EzLog4j.log("<row id='"+Count+"'></row>","I");
	}
	out.println("</rows>");
%>