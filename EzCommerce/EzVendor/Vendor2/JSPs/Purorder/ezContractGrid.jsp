<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iContract.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%
	int contractRows = 0;
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	String SchSearch=request.getParameter("SchSearch");
	if(SchSearch!=null)
	{
		orderType="All";
		String schToSearch=request.getParameter("contractNum");
		mySearch.searchLong(purchctrhdr,"CONTRACT",schToSearch);
	}
	if(purchctrhdr!=null)
		contractRows = purchctrhdr.getRowCount();
		
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");	

	if(contractRows>0)
	{
		String[] sortKey = {contract};
		purchctrhdr.sort( sortKey, false );//false for descending
		
		String contractNum   = null;
		String contractValue = null;
		String currency	     = "";	
		String agreeDate     = null;
		
		///<input type="hidden" name="chkField">
		currency = purchctrhdr.getFieldValueString(0,"CURRENCY");
		if (currency == null){
			currency = "INR";
		}
		FormatDate formatDate = new FormatDate();
		for(int i=0; i<contractRows; i++)
		{
			contractNum 	= Long.parseLong((String)purchctrhdr.getFieldValue(i, contract))+"";
			agreeDate   	= formatDate.getStringFromDate((java.util.Date)purchctrhdr.getFieldValue(i, contrdate),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			contractValue	= myFormat.getCurrencyString(purchctrhdr.getFieldValueString(i, "NETAMOUNT"));
			
			// contractValue=contractValue.substring(0,contractValue.indexOf(".")+3);
			out.println("<row id='"+contractNum+"'><cell><![CDATA[<nobr><a href='ezContractDetails.jsp?contractNum="+contractNum+"&amp;currency="+(String)session.getValue("CURRENCY")+"&amp;orderType="+orderType+"&amp;contractValue="+contractValue+"'>"+contractNum+"</a></nobr>]]></cell><cell>"+agreeDate+"</cell><cell>"+contractValue+"</cell></row>");
		}
	}
	else
	{
		out.println("<row id='"+contractRows+"'></row>");
	}
	out.println("</rows>");
	
%>
	
	
	
