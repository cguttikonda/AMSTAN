<%--
***************************************************************
       /* =====================================
        * Copyright Notice 
	* This file contains proprietary information of Answerthink India Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 
	=====================================*/

       /* =====================================
        * Author : Girish Pavan Cherukuri
	* Team : EzcSuite
	* Date : 16-09-2005
	* Copyright (c) 2005-2006 
	=====================================*/
***************************************************************
--%>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"></jsp:useBean>
<%
	ReturnObjFromRetrieve retWebStats = null;
	Date frd=new Date(fromDate.substring(0,2)+"/"+fromDate.substring(3,5)+"/"+fromDate.substring(6,10));
	Date tod=new Date(toDate.substring(0,2)+"/"+toDate.substring(3,5)+"/"+toDate.substring(6,10));
	SimpleDateFormat sdf=new SimpleDateFormat("MM.dd.yyyy");
	String frdate=sdf.format(frd);
	String todate=sdf.format(tod);
	/**/
		String toDateString = "";
		String toMonthString = "";
		java.util.Date toDateObj = new java.util.Date(toDate);
		toDateObj.setHours(toDateObj.getHours()+24);
		int toDateInt = toDateObj.getDate();
		if(toDateInt <= 10)
			toDateString = "0"+toDateInt;
		else
			toDateString = ""+toDateInt;
		int toMonthInt = toDateObj.getMonth()+1;
		if(toMonthInt <= 10)
			toMonthString = "0"+toMonthInt;
		else
			toMonthString = ""+toMonthInt;
		String formatToDate = toMonthString+"/"+toDateString+"/"+(toDateObj.getYear()+1900);	
	/**/

	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	webStatparams.setFromDate(frdate);
	webStatparams.setToDate(formatToDate);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getTimeStats(mainParams);
%>

