<%@ page import ="ezc.ezsap.V31H.generated.*"%>
<%@ page import ="ezc.ezparam.*"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezvendor.csb.*" %>

<jsp:useBean id="VendManager" class ="ezc.ezvendor.client.EzVendorManager" scope="page" >
</jsp:useBean>


<%
	final String supp = "SUPPLIER";
	final String bank = "BANK";
	final String name = "NAME";
	final String type = "BANKTYPE";
	final String addr = "BANKADDRESS";
	final String acct = "BANKACCOUNT";
	final String atyp = "ACCOUNTTYPE";
	final String rStatus="RECORDSTATUS";
	int count = 0;
	int i = 0;

	ReturnObjFromRetrieve suppacct = null;
	EzVendorParams ioparams = new EzVendorParams();	
	ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();
	newParams.createContainer();
	newParams.setObject(ioparams);
	Session.prepareParams(newParams);
        suppacct = (ReturnObjFromRetrieve)VendManager.getVendorAccounts(newParams);
	count = suppacct.getRowCount();
%>
