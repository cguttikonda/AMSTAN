<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iGetContractsList.jsp"%> 
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	
		
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        String poNum = ""; 
        String contractNum = ""; 
        String agreeDate = ""; 
       
	if(myRetCount>0)
	{
		
		FormatDate formatDate = new FormatDate();
		for(int i=0; i<myRetCount; i++)
		{	
			poNum = ret.getFieldValueString(i,"ORDER");
			contractNum 	= Long.parseLong(ret.getFieldValueString(i,"ORDER"))+"";
			agreeDate   	= fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			out.println("<row id='"+contractNum+"'><cell><![CDATA[<nobr><a href=\"javascript:getAgmtDtl('"+poNum+"')\">"+contractNum+"</a></nobr>]]></cell><cell>"+agreeDate+"</cell></row>");
			
			
		}
	}
	else
	{
		out.println("<row id='"+myRetCount+"'></row>");
	}
	out.println("</rows>");
	
%>
	
	
	
