<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String status		= request.getParameter("status");
	String featured 	= request.getParameter("featured");
	String discontinued	= request.getParameter("discontinued");
	String prod_code	= request.getParameter("proCode");
	String discDate 	= request.getParameter("discDate");
	String replace		= request.getParameter("replace");
	String newFrom	 	= request.getParameter("newFrom");
	String newTo	 	= request.getParameter("newTo");
		
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();

	catalogParams.setIdenKey("MISC_UPDATE");
	String query ="UPDATE EZC_PRODUCTS SET EZP_STATUS = '"+status+"',EZP_FEATURED = '"+featured+"',EZP_DISCONTINUED = '"+discontinued+"',EZP_DISCONTINUE_DATE = '"+discDate+"',EZP_REPLACES_ITEM = '"+replace+"',EZP_NEW_FROM = '"+newFrom+"',EZP_NEW_TO = '"+newTo+"' WHERE EZP_PRODUCT_CODE = '"+prod_code+"'";

	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		ezMiscManager.ezUpdate(catalogParamsMisc);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	out.print(status+"##"+featured+"##"+discontinued+"##"+prod_code+"##"+discDate+"##"+replace+"##"+newFrom+"##"+newTo);
%>