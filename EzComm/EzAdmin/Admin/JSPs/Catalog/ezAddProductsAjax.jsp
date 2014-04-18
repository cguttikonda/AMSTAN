<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String col1 = request.getParameter("col1");
	String col2 = request.getParameter("col2");
	String col3 = request.getParameter("col3");
	String col4 = request.getParameter("col4");
	String col5 = request.getParameter("col5");
	String col6 = request.getParameter("col6");
	String col7 = request.getParameter("col7");
	
		
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();

	catalogParams.setIdenKey("MISC_INSERT");
	String query="INSERT INTO EZC_PRODUCTS(EZP_PRODUCT_CODE,EZP_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_UPC_CODE,EZP_BRAND,EZP_MODEL)VALUES('"+col1+"','"+col2+"','"+col3+"','"+col4+"','"+col5+"','"+col6+"','"+col7+"')";
	
	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		ezMiscManager.ezAdd(catalogParamsMisc);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	out.print(col1+"##"+col2+"##"); 
%>