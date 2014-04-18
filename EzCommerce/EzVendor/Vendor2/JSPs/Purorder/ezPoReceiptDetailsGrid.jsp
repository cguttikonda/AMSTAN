<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<%!
	public String getNumberFormat(String dblValue,int maxDecimal)
	{
		String retValue = "";
		try
		{
			java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
			numberFormat.setMaximumFractionDigits(0);
			numberFormat.setMinimumFractionDigits(maxDecimal);
			if(dblValue != null && !"null".equals(dblValue) && !"".equals(dblValue.trim()))
				retValue = numberFormat.format(Double.valueOf(dblValue))+"";
			else	
				retValue = "0";
		}
		catch(Exception ex)
		{
			retValue = dblValue;
		}
		return retValue;
	}
%>	
<%
	int Count = 0;
	
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	
	String base 			= request.getParameter("base");
	String ponum			= request.getParameter("PurchaseOrder");
	String polin 			= request.getParameter("line");
	String desc 			= request.getParameter("material");
	String materialDescFromCtr 	= request.getParameter("materialDescFromCtr");
	String netOrderAmount 		= request.getParameter("OrderValue");
	String orderCurrency 		= request.getParameter("orderCurrency");
	String vendorNo 		= request.getParameter("vendorNo");
	String orderDate		= request.getParameter("OrderDate");

	
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	java.text.NumberFormat nformat = java.text.NumberFormat.getCurrencyInstance((java.util.Locale)session.getValue("LOCALE"));

	java.util.Hashtable matCodeHash	= (java.util.Hashtable)session.getAttribute("materialNos");
	java.util.Hashtable matDescHash	= (java.util.Hashtable)session.getAttribute("materialDesc");
	
	
	String mySysKeyTemp		=(String)session.getValue("SYSKEY");
	String mySoldToTemp		=(String)session.getValue("SOLDTO");	

	if(vendorNo!=null && !"null".equals(vendorNo) && !"".equals(vendorNo.trim()))
		PurManager.setPurAreaAndVendor(mySysKeyTemp,vendorNo);
	
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	Session.prepareParams(newParams);

	EzPurchaseReceipts retobj = new EzPurchaseReceipts();
	iparams.setOrderNumber(ponum);
	iparams.setPositionNum("00");
	if(base.equals("PContracts")){
		iparams.setPositionNum(polin);
	}
	
	retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceipts(newParams);
	if(retobj != null)
	{
		Count = retobj.getRowCount();
	}
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(Count > 0)
	{
		String rcptStatus = "";
		String rcptLineNo = "";
		String rcptMatDsc = "";
		String matCode 	  = "";
		String matDesc 	  = "";
		String rcptDNNo	  = "";
		String rcptNo	  = "";
		String rcptDate	  = "";
		String delQty	  = "";
		String appQty	  = "";
		String rjctQty	  = "";
		String rjctRsn    = "";
		String purchCd	  = "";
		
		String outputString  = "";
		String recStatusLink = "";
		String recRejctdLink = "";
		
		for (int i=0;i<Count;i++)
		{
			rcptNo		= retobj.getFieldValueString(i, "RECEIPTNUMBER");
			rcptStatus 	= retobj.getFieldValueString(i, "STATUSTEXT");
			rcptLineNo	= retobj.getFieldValueString(i, "RESERVED");

			if(rcptStatus == null || "null".equals(rcptStatus) || "".equals(rcptStatus.trim()))
				rcptStatus = "Received";

			if("Invoiced".equals(rcptStatus) || "Partly Invoiced".equals(rcptStatus))
				recStatusLink = "<![CDATA[<nobr><a href=\"ezWaitPOInvoices.jsp?PurchaseOrder="+ponum+"&base="+base+"&OrderValue="+netOrderAmount+"&orderCurrency="+orderCurrency+"&GRNo="+rcptNo+"\"   onMouseover=\"window.status='Click to view Reciept Details'; return true\" onMouseout=\"window.status=' '; return true\">"+rcptStatus+"</a></nobr>]]>";
			else
				recStatusLink = rcptStatus;
				
			if(rcptLineNo == null || "null".equals(rcptLineNo))
				rcptLineNo = "10";
			
			if(matCodeHash != null && matCodeHash.get(rcptLineNo) != null)
				matCode	= (String)matCodeHash.get(rcptLineNo);
			else
				matCode	= null;
			
			if(matDescHash != null && matDescHash.get(rcptLineNo) != null)
				matDesc	= (String)matDescHash.get(rcptLineNo);
			else	
				matDesc	= null;
			
			if(matCode == null || "null".equals(matCode))
				matCode = "";
			if(matDesc == null || "null".equals(matDesc))
				matDesc = "";
			
			if(!"".equals(matCode))
				rcptMatDsc   	= matCode;
			if("".equals(matCode))
				rcptMatDsc   	= matDesc;
			if("".equals(matDesc))
				rcptMatDsc   	= matCode;
				
			rcptDNNo	= retobj.getFieldValueString(i, "REFDOCNO");
			if(rcptDNNo == null || "null".equals(rcptDNNo) || "".equals(rcptDNNo))
				rcptDNNo = "";
			
			rcptDate	= formatDate.getStringFromDate((Date)retobj.getFieldValue(i, "RECEIPTDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			delQty		= getNumberFormat(retobj.getFieldValueString(i, "DELIVEREDQTY"),0);
			appQty		= getNumberFormat(retobj.getFieldValueString(i, "APPROVEDQUANTITY"),0);
			rjctQty		= getNumberFormat(retobj.getFieldValueString(i, "REJECTEDQUANTITY"),0);
			rjctRsn    	= retobj.getFieldValueString(i, "REASONFORREJECTIONDESCRIPTION");
			purchCd		= retobj.getFieldValueString(i, "PURCHASESTATUSCODE");
			
			
			
			if("None".equals(purchCd))
				purchCd = rjctRsn;
				
			if("0".equals(rjctQty))	
				recRejctdLink = rjctQty;
			else
				recRejctdLink = "<![CDATA[<nobr><a href=\"ezReasonForRejection.jsp?Reason="+purchCd+"&order="+ponum+"&line="+polin+"&OrderValue="+netOrderAmount+"&OrderDate="+orderDate+"&orderCurrency="+orderCurrency+"\"   onMouseover=\"window.status='Click to view the reason for rejection'; return true\" onMouseout=\"window.status=' '; return true\">"+rjctQty+"</a></nobr>]]>";
			
			outputString  = "<row id='"+rcptNo+"_"+i+"'>";
			outputString += "<cell>"+recStatusLink+"</cell><cell>"+rcptMatDsc+"</cell><cell>"+rcptDNNo+"</cell>";;
			outputString += "<cell>"+rcptNo+"</cell><cell>"+rcptDate+"</cell>";
			outputString += "<cell>"+delQty+"</cell><cell>"+appQty+"</cell><cell>"+recRejctdLink+"</cell></row>";
			
			out.println(outputString);
 		}	

	}
	else
	{
		out.println("<row id='0'></row>");
	}
	out.println("</rows>");	
	
%>