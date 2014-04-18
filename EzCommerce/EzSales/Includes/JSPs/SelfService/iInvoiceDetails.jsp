<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.client.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />

<%
	String datesFlag		=request.getParameter("DatesFlag");
	String base 			= request.getParameter("FromForm");
	String fd 			= request.getParameter("FromDate");
	String td 			= request.getParameter("ToDate");
	String monthOpt			= request.getParameter("ezMonths");

	String custInvNo 		= request.getParameter("custInvNo");
	String sapInvNo 		= request.getParameter("sapInvNo");
	String InvDate 			= request.getParameter("InvDate");

	EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();
	eiParams.setCustInvoiceNo(custInvNo);
	eiParams.setSalesDocNum("123");	//Some Dummy Number
	eiParams.setSelection("I");  	//I
	ecparams.setObject(eiParams);
	Session.prepareParams(ecparams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);
	ReturnObjFromRetrieve billHeaders 	= (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");
	ReturnObjFromRetrieve billItems 	= (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_ITEMS_OUT");
%>
