<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String type 	= request.getParameter("type");
	String webSKU 	= request.getParameter("webSKU");
	String prodCode	= request.getParameter("proCode");
	
	String webProdId= request.getParameter("webProdId");
	String upcCode 	= request.getParameter("upcCode");
	String erpCode	= request.getParameter("erpCode");
	
	String brand 	= request.getParameter("brand");
	String family 	= request.getParameter("family");
	String model	= request.getParameter("model");
	
	String color 	= request.getParameter("color");
	String curPrice = request.getParameter("curPrice");
	String futPrice	= request.getParameter("futPrice");
	
	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();

	catalogParams.setIdenKey("MISC_UPDATE");
	String query ="UPDATE EZC_PRODUCTS SET EZP_TYPE = '"+type+"',EZP_WEB_SKU = '"+webSKU+"',EZP_WEB_PROD_ID = '"+webProdId+"',EZP_UPC_CODE = '"+upcCode+"',EZP_ERP_CODE = '"+erpCode+"',EZP_BRAND = '"+brand+"', EZP_FAMILY = '"+family+"',EZP_MODEL = '"+model+"',EZP_COLOR = '"+color+"',EZP_CURR_PRICE = '"+curPrice+"',EZP_FUTURE_PRICE = '"+futPrice+"' WHERE EZP_PRODUCT_CODE = '"+prodCode+"'";

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
	out.print(type+"##"+webSKU+"##"+prodCode+"##"+webProdId+"##"+upcCode+"##"+erpCode+"##"+brand+"##"+family+"##"+model+"##"+color+"##"+curPrice+"##"+futPrice);
%>