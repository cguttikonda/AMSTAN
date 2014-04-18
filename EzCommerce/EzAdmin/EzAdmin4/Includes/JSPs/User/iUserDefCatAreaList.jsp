<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Currency.jsp"%>

<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%!
// Start Declarations

final String SYSTEM_KEY = "ESKD_SYS_KEY";
final String SYSTEM_KEY_DESC_LANGUAGE = "ESKD_LANG";
final String SYSTEM_KEY_DESCRIPTION = "ESKD_SYS_KEY_DESC";

final String CATALOG_NUMBER = "ECG_CATALOG_NO";
final String CATALOG_SYSTEM_KEY = "ECG_SYS_KEY";
final String CATALOG_PRODUCT_GROUP = "ECG_PRODUCT_GROUP";

final String ERP_CONTACT_NAME = "ECA_NAME";


//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retcatarea = null;

String userBP = null;
String bus_user= null;

//Get Business User Value
bus_user = request.getParameter("BusUser");
bus_user = bus_user.trim();

EzcUserParams uparams = new EzcUserParams();
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.setUserId(bus_user);
uparams.createContainer();
uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

String catalog_area = null;
String user_catarea = null;

//Get User Catalog Areas
retcatarea = (ReturnObjFromRetrieve)UserManager.getUserCatalogAreas(uparams);
retcatarea.check();


//Get Catalog Area for the user
user_catarea = (String)UserManager.getUserDefSysKey(uparams);
if ( user_catarea == null ){
	user_catarea = (String)retcatarea.getFieldValue(0,CATALOG_SYSTEM_KEY);
}

if (catalog_area == null) {
	catalog_area = user_catarea;
}
catalog_area.trim();

%>