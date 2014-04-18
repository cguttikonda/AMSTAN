<%@ page import="ezc.ezadmin.busspartner.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CM" class="ezc.client.CEzBussPartnerManager" scope="session" />
<%
	//String user_id = pCheckBox[0];
	String user_id   = request.getParameter("BusinessUser");
	ReturnObjFromRetrieve ret = null;
	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(user_id);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);


	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();

	String partnerNumber = ret.getFieldValueString(0,"EU_BUSINESS_PARTNER");
	partnerNumber = partnerNumber.trim();
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bnkparams.setPartnerNumber("'"+partnerNumber+"'");
	bparams.setObject(bnkparams);
	Session.prepareParams(bparams);
	CM.deleteBussPartners(bparams);

%>