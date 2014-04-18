<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />

<%
	ezc.client.EzcUtilManager UtilManager = null;

	//String soldto=(String) session.getValue("AgentCode");
	String soldto=(String) session.getValue("docSoldTo");
	//out.println(soldto);
	String syskey=(String) session.getValue("SalesAreaCode");

	 UtilManager = new ezc.client.EzcUtilManager(Session);
	String defPartnNum =UtilManager.getUserDefErpSoldTo();


	if(!soldto.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(syskey,soldto);

	String salesDocNo = request.getParameter("SalesOrder");

	EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();

	eiParams.setCustInvoiceNo("1");
	eiParams.setSalesDocNum(salesDocNo);
	eiParams.setSelection("H");  

	ecparams.setObject( eiParams );
	Session.prepareParams(ecparams);

	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);

	//ReturnObjFromRetrieve billHeaders = retObj.getBillingHeadersOut();
	ReturnObjFromRetrieve billHeaders = (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");
	
	if(!soldto.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(syskey,defPartnNum);
%>

