<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
	ReturnObjFromRetrieve reterpdef = null;
	EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
	bnkparams2.setLanguage("EN");
	bnkparams2.setCust_id("0000000041");//0000700722
	bnkparams2.setSys_key("NOT");
	bparams2.setObject(bnkparams2);
	Session.prepareParams(bparams2);
	reterpdef = (ReturnObjFromRetrieve)BPManager.getErpCustomerDefaults(bparams2);
%>
