<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>



<%
// Key Variables : Globals in the page
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve catdesc = null;
ReturnObjFromRetrieve retcat = null;

String sys_key = null;
String catalog_number = null;
String catalog_desc = null;

//Read All Catalog Numbers
EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);

catalogParams.setLanguage("EN");


catalog_number = request.getParameter("CatNumber");	
catalog_desc = request.getParameter("catDesc");	

// Get List Of System Keys
catalogParams.setCatalogNumber(catalog_number); // Moved 12/21/2000
retsyskey = (ReturnObjFromRetrieve)catalogObj.getCatalogAreas(catalogParams);
retsyskey.check();

sys_key = request.getParameter("SystemKey");	
if (sys_key == null) 
	sys_key = (retsyskey.getFieldValue(0,SYSTEM_KEY)).toString();
	
sys_key = sys_key.trim();

//Get Product Groups for the Catalog Number
catalogParams.setSysKey(sys_key);
ret = (ReturnObjFromRetrieve)catalogObj.readCatalogSelected(catalogParams);
ret.check();


%>