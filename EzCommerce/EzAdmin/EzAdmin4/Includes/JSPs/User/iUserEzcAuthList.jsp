<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>

<%@ include file="../../Lib/ArmsConfig.jsp" %>


<%
	EzcParams einParams = new EzcParams(false);
	Session.prepareParams( einParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( einParams );

ReturnObjFromRetrieve retuserinfo = null;
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve retauth = null;
ReturnObjFromRetrieve retuserauth = null;

String bus_user = request.getParameter("BusUser");
String FromAdd = request.getParameter("FromAdd");
if ( FromAdd == null )
{
	FromAdd = "No";
}

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();

ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
uparams.setUserId(bus_user);
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);


retuserinfo = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);

String Bus_Partner = (String)(retuserinfo.getFieldValue(0,USER_BUSINESS_PARTNER));
%>