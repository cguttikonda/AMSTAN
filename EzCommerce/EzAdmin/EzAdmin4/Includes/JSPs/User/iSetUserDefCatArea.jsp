<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Currency.jsp"%>

<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>


<%
// Key Variables
ReturnObjFromRetrieve retUserCatAreas = null;

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


//Get User Catalog Areas
retUserCatAreas = (ReturnObjFromRetrieve)UserManager.getAddCatalogAreas(uparams);
retUserCatAreas.check();
%>