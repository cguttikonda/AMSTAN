<%@ page import ="ezc.ezparam.*,ezc.ezpurchase.params.*,ezc.ezutil.FormatDate" %>
<%@ include file="../../Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.client.*" %>
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

			retValue = retValue.replaceAll(",","");
		}
		catch(Exception ex)
		{
			retValue = dblValue;
		}
		return retValue;
	}
%>
<%

	String fromDate	=request.getParameter("FromDate");
	String toDate	=request.getParameter("ToDate");
	
	if(fromDate == null || toDate == null)
	{
		
		Date fromDateObj =  new Date();
		int prevdate =  fromDateObj.getDate();
		int prevmonth = fromDateObj.getMonth()+1;
		int prevyear =  fromDateObj.getYear()+1900;
				
		Date toDateObj 	= new Date();
		toDateObj.setDate((fromDateObj.getDate()+30));
		int today 	= toDateObj.getDate();
		int thismonth  	= toDateObj.getMonth()+1;
		int thisyear 	= toDateObj.getYear()+1900;
		
		String todayStr 	= "";
		String prevdateStr 	= "";
		String thismonthStr 	= "";
		String prevmonthStr 	= "";

		if(today < 10)
			todayStr = "0"+today;
		else
			todayStr = ""+today;

		if(prevdate < 10)
			prevdateStr = "0"+prevdate;
		else
			prevdateStr = ""+prevdate;

		if(thismonth < 10)
			thismonthStr = "0" + thismonth;
		else
			thismonthStr = "" + thismonth;

		if(prevmonth < 10)
			prevmonthStr = "0" + prevmonth;	
		else	
			prevmonthStr = "" + prevmonth;

		fromDate = prevmonthStr+(String)session.getValue("DATESEPERATOR")+prevdateStr+(String)session.getValue("DATESEPERATOR")+prevyear;
		toDate   = thismonthStr+(String)session.getValue("DATESEPERATOR")+todayStr+(String)session.getValue("DATESEPERATOR")+thisyear;
		
	}			
	
	Date ToDate = null;
	Date FromDate = null;	
	EzPurchHdrXML hdrXML = new EzPurchHdrXML();
	if ((fromDate!=null)&&(toDate!=null))
	{
         	
		FromDate 	= new Date(fromDate);
		ToDate 		= new Date(toDate);
		
		EzPurchaseManager PoManager=new EzPurchaseManager();

		EzPSIInputParameters iparams = new EzPSIInputParameters();
		EzcPurchaseParams newParams = new EzcPurchaseParams();
		EziPurchaseInputParams testParams = new EziPurchaseInputParams();
		testParams.setFromDate(FromDate);
		testParams.setSelectionFlag("D");
		newParams.setObject(iparams);
		newParams.setObject(testParams);
		Session.prepareParams(newParams);
		hdrXML = (EzPurchHdrXML)PoManager.ezGetPurchaseOrderListSince(newParams);
	}
	int Count = hdrXML.getRowCount();
	if (fromDate == null)
		fromDate = "";
	if (toDate == null)
		toDate = "";
%>
