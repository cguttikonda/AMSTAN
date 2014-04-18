<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String prodCode = request.getParameter("proCode");
	String details 	= request.getParameter("details");
	String desc	= request.getParameter("desc");
	
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();

	catalogParams.setIdenKey("MISC_UPDATE");
	String query ="UPDATE EZC_PRODUCT_DESCRIPTIONS SET EPD_PRODUCT_DESC = '"+desc+"',EPD_PRODUCT_DETAILS= '"+details+"'  WHERE EPD_PRODUCT_CODE = '"+prodCode+"'";

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
	out.print(prodCode+"##"+details+"##"+desc);
%>