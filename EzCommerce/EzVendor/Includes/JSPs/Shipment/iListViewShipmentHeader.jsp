<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%
	String userType		= (String)session.getValue("UserType");
	String ponum		= request.getParameter("baseValues");
	String base 		= request.getParameter("base");
	String OrderValue  	= request.getParameter("OrderValue");
	String orderCurrency 	= request.getParameter("orderCurrency");
	String currency 	= request.getParameter("currency");
	String OrderDate 	= request.getParameter("OrderDate");
	String currSysKey 	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	String OrderDate 	= request.getParameter("OrderDate");
	
	EzShipmentManager shipManager= new EzShipmentManager();
	EziShipmentInfoParams inParams =new EziShipmentInfoParams();
	inParams.setSelection("H");
	inParams.setPurchaseOrderNumber(ponum);
	inParams.setSysKey(currSysKey);
	inParams.setSoldTo(defErpVendor);
	EzcParams ezcparams= new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(inParams);
	if ("3".equals(userType))
		inParams.setStatus("N");
	else if ("2".equals(userType))
		inParams.setStatus("Y");
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=ret=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);
	ReturnObjFromRetrieve finalret=new ReturnObjFromRetrieve();
	if ((ret!=null)&&(ret.getRowCount()>0))
	{
		finalret= (ReturnObjFromRetrieve)ret.getFieldValue("HEADER");
	}

%>
