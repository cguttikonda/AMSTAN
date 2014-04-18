<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>



<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>

<%@ include file="../../Lib/ArmsConfig.jsp" %>


<%
	EzcParams einParams = new EzcParams(false);
	Session.prepareParams( einParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( einParams );
%>

<%
// Key Variables
ReturnObjFromRetrieve retuserinfo = null;
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve retauth = null;
ReturnObjFromRetrieve retuserauth = null;

//Get Selected User Value
String bus_user   = request.getParameter("BusUser");
String bus_sysKey = request.getParameter("BPsyskey");


String websyskey = request.getParameter("WebSysKey");
String FromAdd = request.getParameter("FromAdd");

if ( FromAdd == null )
{
	FromAdd = "No";
}
if(bus_sysKey!=null && !"null".equals(bus_sysKey))
	websyskey = bus_sysKey	;

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();

ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
uparams.setUserId(bus_user);
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

// Get Basic User Information
retuserinfo = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
retuserinfo.check();
//retuserinfo = (ReturnObjFromRetrieve)UserManager.getUserData(servlet, bus_user);

//Get Business Partenr for a user
String Bus_Partner = (String)(retuserinfo.getFieldValue(0,USER_BUSINESS_PARTNER));
%>