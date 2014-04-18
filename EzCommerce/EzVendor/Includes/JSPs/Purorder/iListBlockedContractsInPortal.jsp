<%@ page import ="ezc.ezparam.*" %>

<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
	
	 String orderType = request.getParameter("type");
	 String sysKey = (String) session.getValue("SYSKEY");
	 String soldTo = (String) session.getValue("SOLDTO");
	 ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	 mainParams.setLocalStore("Y");	    
	 ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
	 iParams.setDocStatus("K");
	 iParams.setSysKey(sysKey);
	 mainParams.setObject(iParams);	
	 Session.prepareParams(mainParams);
	 ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);
	 int Count =0;
	
	 if(ret != null)
	 {
		Count=ret.getRowCount();
		if(Count > 0)
		{
			ret.sort(new String[]{"DOCDATE"},false);
		}
	 }
%>
