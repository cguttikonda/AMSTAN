<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>

<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>

<%@page import="ezc.ezparam.*"%>

<%
	
	boolean showData=false;

        String poNum 		= request.getParameter("PurchaseOrder");
        String orderType 	= request.getParameter("orderType");
        String OrderDate 	= request.getParameter("OrderDate");
        String NetAmount 	= request.getParameter("NetAmount");

	EzcParams ezcparams= new EzcParams(false);

	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);
	ReturnObjFromRetrieve retObj =  (ReturnObjFromRetrieve)PoManager.ezPurchaseOrderDeliverySchedule(newParams);

	//out.println(">>>>>>>>>"+retObj.toEzcString());
        int Count = retObj.getRowCount();

	String sysKey= (String) session.getValue("SYSKEY");
	String soldTo = (String) session.getValue("SOLDTO");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);

   	ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();	

	iParams.setDocNo(poNum);
	iParams.setFlag("N");

	mainParams.setObject(iParams);	
	mainParams.setLocalStore("Y");	
    	Session.prepareParams(mainParams);

    	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPODeliverySchedule(mainParams);	

	int retCount = ret.getRowCount();
	
	if(orderType != null && orderType.equals("Open") && retCount==0)
	{
		showData=false;
	}
	else
	{
		showData=true;
	}


%>