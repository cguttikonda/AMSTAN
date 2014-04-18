<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"> 
</jsp:useBean> 

<jsp:useBean id="SysConManager" class="ezc.client.EzSystemConfigManager" scope="session"> 
</jsp:useBean> 


<%
// Key Variables
ReturnObjFromRetrieve retbp = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retcust = null;
ReturnObjFromRetrieve retdef = null;
ReturnObjFromRetrieve reterpdef = null;
ReturnObjFromRetrieve retuser = null;

String userBP = null;
String bus_user= null;

//Get Business User Value
bus_user = request.getParameter("BusUser");

EzcUserParams uparamsU= new EzcUserParams();
Session.prepareParams(uparamsU);

EzcUserNKParams ezcUserNKParamsU = new EzcUserNKParams();
ezcUserNKParamsU.setLanguage("EN");
uparamsU.createContainer();
boolean result_flagU = uparamsU.setObject(ezcUserNKParamsU);
String sys_key = request.getParameter("SystemKey");
//Get All Users
retuser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparamsU);
int uRows=retuser.getRowCount();

retuser.check();
if(uRows>0){
if ( bus_user == null )
{
	bus_user = retuser.getFieldValueString(0,"EU_ID");
	
}
bus_user = bus_user.trim();

// System Configuration Class
//EzSystemConfig ezc = new EzSystemConfig();

EzcUserParams uparams= new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();

ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
uparams.setUserId(bus_user);
boolean result_flag = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

//Get the System Keys for the User
retsyskey = (ReturnObjFromRetrieve)UserManager.getUserCatalogAreas(uparams);
retsyskey.check();
//retsyskey = AdminObject.getUserCatalogAreas(servlet, bus_user);

//Get System Key Value

if (sys_key == null) {
	sys_key = (retsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
}
sys_key = sys_key.toUpperCase();
sys_key = sys_key.trim();

ezcUserNKParams.setLanguage("EN");
ezcUserNKParams.setSys_Key(sys_key);
uparams.createContainer();
uparams.setUserId(bus_user);
boolean result_flag1 = uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

//Get ERP Customer Defaults
reterpdef = (ReturnObjFromRetrieve)UserManager.getAddCatAreaUserDefaults(uparams);
reterpdef.check();
//reterpdef = AdminObject.getAddCatAreaUserDefaults(servlet, bus_user, sys_key);

}
%>