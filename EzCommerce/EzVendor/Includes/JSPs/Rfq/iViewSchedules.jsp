<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "java.util.*"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>


<%
	String poNum = request.getParameter("PurchaseOrder");
	String OrderDate = request.getParameter("OrderDate");
	String EndDate = request.getParameter("EndDate");

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
	//out.println("=retObj="+retObj.toEzcString());
        	int Count = retObj.getRowCount();

/*	EzPurchDtlXML dtlXML = null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);

	dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams);

	java.util.Date ordDate = (java.util.Date)dtlXML.getFieldValue(0,"ORDERDATE"); 

	int Count = dtlXML.getRowCount();
*/
%>
