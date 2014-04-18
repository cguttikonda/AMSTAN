<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>



<%
// Key Variables
ReturnObjFromRetrieve ret = null;
//System Type variable
String sysType = null;
String Sys_Key = request.getParameter("SystemKey");
String Prod_Group = request.getParameter("ProductGroup");
String Lang = request.getParameter("Language");

if (Sys_Key != null && Prod_Group != null) 
{
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setSysKey(Sys_Key);
	catalogParams.setLanguage("EN");
	catalogParams.setProductGroup(Prod_Group);
	ret = (ReturnObjFromRetrieve)catalogObj.readAdminCatalogDetails(catalogParams);
	ret.check();
}
%>