<%@page import = "java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%@page import = "ezc.ezcommon.*" %>
<%@page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<%
	String orderBase        = request.getParameter("orderBase");
	String showData		= request.getParameter("showData");
	String backFlg          = request.getParameter("backFlg");
			
	if(showData == null || "null".equals(showData))
		showData = "N";
	
	String ponum	= request.getParameter("ponum");
	if(ponum == null || "null".equals(ponum))
		ponum = "";
	
	String sysKey 		= (String) session.getValue("SYSKEY");
	String soldTo 		= (String) session.getValue("SOLDTO");
	String userType 	= (String) session.getValue("UserType");
	
	ReturnObjFromRetrieve finalret = new ReturnObjFromRetrieve();
	int count = 0;
	
	if("Y".equals(showData))
	{
		
		EziShipmentInfoParams inParams1 =new EziShipmentInfoParams();
		inParams1.setSelection("H");
		inParams1.setPurchaseOrderNumber(ponum);
		inParams1.setSysKey(sysKey);
		inParams1.setSoldTo(soldTo);		//////+"' AND EZSH_STATUS='N"
		if ("3".equals(userType))
			inParams1.setStatus("N");
		else if ("2".equals(userType))
			inParams1.setStatus("Y");
		EzcParams ezcparams = new EzcParams(true);
		ezcparams.setLocalStore("Y");
		ezcparams.setObject(inParams1);	
		Session.prepareParams(ezcparams);
		ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);
		if ((ret!=null)&&(ret.getRowCount()>0))
		{
			finalret = (ReturnObjFromRetrieve)ret.getFieldValue("HEADER");
			if(finalret != null)
				count = finalret.getRowCount();
		}	
	}
%>
