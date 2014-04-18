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
	//Get WebStats List Starts
	
	
	//This fromLoginDetails parameter only for Login user Webstats.
	String fromLoginDetails = "";
	if(request.getParameter("fromLoginDetails") != null)
	{
		fromLoginDetails = request.getParameter("fromLoginDetails");
		if("Y".equals(fromLoginDetails))
		{
			StringBuffer allKeys=new StringBuffer("");
			int retCount = ret.getRowCount();
			for(int i=0;i<retCount;i++)
			{
				if(i==0)
				{
					allKeys.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}
				else
				{
					allKeys.append(",");
					allKeys.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}
			}
			WebSysKey = allKeys.toString();
		}
	}

	ReturnObjFromRetrieve retWebStats = null;
	EzcParams mainParams = new EzcParams(false);
	EziWebStatsParams  webStatparams= new EziWebStatsParams();
	webStatparams.setSysKey(WebSysKey);
	
	Date frd=new Date(fromDate.substring(0,2)+"/"+fromDate.substring(3,5)+"/"+fromDate.substring(6,10));
	Date tod=new Date(toDate.substring(0,2)+"/"+toDate.substring(3,5)+"/"+toDate.substring(6,10));
	SimpleDateFormat sdf=new SimpleDateFormat("MM.dd.yyyy");
	
	String frdate=sdf.format(frd);
	String todate=sdf.format(tod);
	
	//out.println("frdate>>"+frdate);
	//out.println("todate>>"+todate);
	
	String toDateString = "";
		String toMonthString = "";
		java.util.Date toDateObj = new java.util.Date(toDate);
		int toDateInt = toDateObj.getDate()+1;
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

	webStatparams.setFromDate(frdate);
	webStatparams.setToDate(formatToDate);
	mainParams.setObject(webStatparams);
	Session.prepareParams(mainParams);
	
	retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getWebStatsList(mainParams);
	
	
	if(request.getParameter("fromLoginDetails") != null)
	{
		fromLoginDetails = request.getParameter("fromLoginDetails");
		if("Y".equals(fromLoginDetails))
		{
			String userId = (String)Session.getUserId();
			int retWebStatsCount = retWebStats.getRowCount();
			for(int i=retWebStatsCount-1;i>=0;i--)
			{
				if(!userId.equals(retWebStats.getFieldValue(i,"USER_ID")))
				{
					retWebStats.deleteRow(i);
				}
			}
		}
	}
	
	int retWebStatsCountList = 0;
	if(retWebStats!=null)
	{
		retWebStatsCountList = 	retWebStats.getRowCount();
	}
	//Get WebStats List Ends

%>

