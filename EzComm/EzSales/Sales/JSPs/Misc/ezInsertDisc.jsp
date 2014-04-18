<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	ezc.ezshipment.client.EzShipmentManager dsclmrManager = new ezc.ezshipment.client.EzShipmentManager();
	ezc.ezparam.EzcParams dsclmrparams = new ezc.ezparam.EzcParams(true);
	ezc.ezparam.EzcUserParams dsclmrusrparams= new ezc.ezparam.EzcUserParams();
	ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Insert>>>>>>>>>>>>>>>>>>>>>>","D");
	ezc.ezshipment.client.EzShipmentManager dsclmrManager_A= new ezc.ezshipment.client.EzShipmentManager();
	dsclmrusrparams = new ezc.ezparam.EzcUserParams();
	dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
	dsclmrparams.setObject(dsclmrusrparams);
	Session.prepareParams(dsclmrparams);
	dsclmrManager.ezPutDisclaimerStamp(dsclmrparams);
	session.putValue("DISCLAIMER","Y");
%>			